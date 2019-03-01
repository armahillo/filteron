workers ENV.fetch("WEB_CONCURRENCY") { 2 }

thread_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads thread_count, thread_count

local_port = ENV.fetch("PORT") { 3000 }
local_root = ENV["HOME"]

port local_port
environment ENV.fetch("RACK_ENV") { "development" }

if ENV["HTTPS_LOCAL"] == "true"
  key = "#{local_root}/.ssl/localhost.key"
  cert = "#{local_root}/.ssl/localhost.crt"
  bind "ssl://localhost:#{local_port}?key=#{key}&cert=#{cert}"
end

preload_app!

before_fork do
  ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
end

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

plugin :tmp_restart
