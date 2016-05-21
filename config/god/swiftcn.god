# /etc/god/conf.d/swiftcn.god file
# doc https://ruby-china.org/topics/21354 or http://godrb.com/
# 开机启动
# source /etc/profile.d/rvm.sh && god -c /etc/god/conf.d/swiftcn.god

app_name = "swiftcn"

rails_env = ENV['RAILS_ENV'] || 'production'
rails_root = ENV['RAILS_ROOT'] || "/var/www/#{app_name}"


God.watch do |w|
  
  w.name = app_name
  w.interval = 30.seconds # default

  w.start = "cd #{rails_root}/current && bundle exec puma --config ./config/puma-web.rb -e #{rails_env} -d"

  w.stop = "pumactl -P #{rails_root}/shared/tmp/pids/puma.pid stop"

  w.restart = "pumactl -P #{rails_root}/shared/tmp/pids/puma.pid restart"

  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  w.pid_file = "#{rails_root}/shared/tmp/pids/puma.pid"

  w.log = "#{rails_root}/shared/log/god.log"

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
      c.times = [3, 5] # 5次里面有2次超过100MB，就restart
    end

    restart.condition(:cpu_usage) do |c|
      c.above = 99.percent
      c.times = 5
    end
  end
  
  # lifecycle
  # 假如watch在5分钟里被启动或者重启了5次，然后不再监视它。。。然后10分钟后，再次监视他看看是否只是一个临时的问题；假如进程在两小时里依然不稳定，然后彻底放弃监视。
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