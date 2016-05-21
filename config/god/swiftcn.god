# /etc/god/conf.d/swiftcn.god file
# doc https://beyondalbert.com/rails-with-god/ or http://godrb.com/

app_name = "swiftcn"

rails_env = ENV['RAILS_ENV'] || 'production'
rails_root = ENV['RAILS_ROOT'] || "/var/www/#{app_name}"


God.watch do |w|
  w.name = watch
  w.interval = 30.seconds # default

  w.start = "cd #{rails_root}/current && bundle exec puma --config ./config/puma-web.rb -e #{rails_env} -d"

  w.stop = "kill -TERM `cat #{rails_root}/shared/tmp/pids/puma.pid`"

  w.restart = "kill -USR2 `cat #{rails_root}/shared/tmp/pids/puma.pid`"

  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.pid_file = "#{rails_root}/shared/tmp/pids/puma.pid"

  w.uid = app_name
  w.gid = app_name

  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end

  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 100.megabytes
      c.times = [3, 5] # 3 out of 5 intervals
    end

    restart.condition(:cpu_usage) do |c|
      c.above = 99.percent
      c.times = 5
    end
  end
  # lifecycle
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end