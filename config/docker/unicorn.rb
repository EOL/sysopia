app_dir = "/app"
ENV["SYSOPIA_ENV"] = "production"

working_directory app_dir

pid "#{app_dir}/tmp/unicorn.pid"

stderr_path "#{app_dir}/log/unicorn.stderr.log"
stdout_path "#{app_dir}/log/unicorn.stdout.log"

worker_processes 2
listen 8080, :tcp_nopush => true
timeout 30

