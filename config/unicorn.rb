root = "/home/craig/apps/hagglefree/current"
listen "127.0.0.1:8080"
worker_processes 2
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"