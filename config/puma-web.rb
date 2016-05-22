#!/usr/bin/env puma

# daemon service
# https://github.com/puma/puma/tree/master/tools/jungle/init.d

#rails的运行环境
environment 'production'
threads 4, 10
workers 1

#项目名
app_name = "swiftcn"
#项目路径
application_path = "/var/www/swiftcn"
#这里一定要配置为项目路径下地current
directory "#{application_path}/current"

#下面都是 puma的配置项
pidfile "#{application_path}/shared/tmp/pids/puma.pid"
state_path "#{application_path}/shared/tmp/sockets/puma.state"
stdout_redirect "#{application_path}/shared/log/puma.stdout.log", "#{application_path}/shared/log/puma.stderr.log"
bind "unix://#{application_path}/shared/tmp/sockets/puma.sock"
activate_control_app "unix://#{application_path}/shared/tmp/sockets/pumactl.sock"

#后台运行
# daemonize true
on_restart do
  puts 'On restart...'
end

on_worker_boot do
  # $redis.client.reconnect
  ActiveRecord::Base.connection.reconnect!
end

preload_app!