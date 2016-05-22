require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
# require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
# require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, 'root@swiftcn.io'
set :deploy_to, '/var/www/swiftcn'
set :repository, 'git@github.com:iBcker/swiftcn.git'
set :branch, 'master'

set :god_name, 'swiftcn'

# For system-wide RVM install.
#   set :rvm_path, '/usr/local/rvm/bin/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/settings.local.yml', 'log', 'tmp', 'public/uploads']

# Optional settings:
#   set :user, 'foobar'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use[ruby-1.9.3-p125@default]'

  ruby_version = File.read('.ruby-version').strip
  raise "Couldn't determine Ruby version: Do you have a file .ruby-version in your project root?" if ruby_version.empty?
  queue %{
    source /etc/profile.d/rvm.sh
    rvm use #{ruby_version} || exit 1
  }
  
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do

  %w{log tmp/pids tmp/sockets config public/uploads}.each do |dir|
    queue! %[mkdir -p "#{deploy_to}/#{shared_path}/#{dir}"]
    queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/#{dir}"]
  end

  queue! %[touch "#{deploy_to}/#{shared_path}/config/settings.local.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/settings.local.yml'."]

  invoke :'god:install'

  if repository
    repo_host = repository.split(%r{@|://}).last.split(%r{:|\/}).first
    repo_port = /:([0-9]+)/.match(repository) && /:([0-9]+)/.match(repository)[1] || '22'

    queue %[
      if ! ssh-keygen -H  -F #{repo_host} &>/dev/null; then
        ssh-keyscan -t rsa -p #{repo_port} -H #{repo_host} >> ~/.ssh/known_hosts
      fi
    ]
  end
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    # invoke :'sidekiq:quiet'

    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"

      invoke :'god:syn_config'
      invoke :'god:restart'
      # invoke :'sidekiq:restart'
    end
  end
end


namespace :god do

  desc 'install god gem'
  task :install => :environment do
    queue! %[gem install god]
    queue! %[mkdir -p /etc/god/conf.d/]
  end

  desc 'syn god config'
  task :syn_config => :environment do
    queue! %[command cp #{deploy_to}/#{current_path}/config/god/swiftcn.god /etc/god/conf.d/#{god_name}.god]
    #加载或者启动god
    queue! %[god load /etc/god/conf.d/#{god_name}.god || god -c /etc/god/conf.d/#{god_name}.god]
  end

  desc 'start god'
  task :start => :environment do
    queue! "god start #{god_name}"
  end

  desc 'stop god'
  task :stop => :environment do
    queue! "god stop #{god_name}"
  end

  desc 'restart god'
  task :restart => :environment do
    queue! "god restart #{god_name}"
  end

end


namespace :nginx do

  desc 'syn nginx config'
  task :syn_config do
    queue! %[command cp #{deploy_to}/#{current_path}/config/nginx/swiftcn.conf /etc/nginx/conf.d/swiftcn.conf]
  end

  desc 'start nginx'
  task :start do
    queue "service nginx start"
  end

  desc 'stop nginx'
  task :stop do
    queue "service nginx stop"
  end

  desc 'restart nginx'
  task :restart do
    queue "service nginx restart"
  end

  desc 'reload nginx'
  task :reload do
    queue "service nginx reload"
  end
end


namespace :sidekiq do

  # ### sidekiq:quiet
  desc "Quiet sidekiq (stop accepting new work)"
  task :quiet => :environment do
    queue %[sidekiqctl quiet "#{deploy_to}/#{shared_path}/tmp/pids/sidekiq.pid"]
  end

  # ### sidekiq:stop
  desc "Stop sidekiq"
  task :stop => :environment do
    queue %[sidekiqctl stop "#{deploy_to}/#{shared_path}/tmp/pids/sidekiq.pid"]
  end

  # ### sidekiq:start
  desc "Start sidekiq"
  task :start => :environment do
    queue %[cd #{deploy_to}/#{current_path} && bundle exec sidekiq -d -e production -C #{deploy_to}/#{current_path}/config/sidekiq.yml]
  end

  # ### sidekiq:restart
  desc "Restart sidekiq"
  task :restart do
    invoke :'sidekiq:stop'
    invoke :'sidekiq:start'
  end

  desc "Tail log from server"
  task :log => :environment do
    queue %[tail -f #{sidekiq_log}]
  end

end


# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers
