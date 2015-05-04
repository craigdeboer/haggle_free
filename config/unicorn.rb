root = "/home/craig/apps/hagglefree/current"
listen "127.0.0.1:8080"
worker_processes 2
working_directory root
pid "home/craig/apps/hagglefree/shared/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"