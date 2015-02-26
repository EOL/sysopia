app_dir = "/app"

working_directory app_dir

pid "#{app_dir}/tmp/unicorn.pid"

stderr_path "#{app_dir}/log/unicorn.stderr.log"
stdout_path "#{app_dir}/log/unicorn.stdout.log"

worker_processes ENV["SYSTUBE_UNICORN_WORKERS"]
listen "/tmp/unicorn.sock", :backlog => 64
timeout 30
