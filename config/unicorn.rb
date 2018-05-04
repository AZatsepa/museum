
if ENV['RAILS_ENV'] == 'development'
  worker_processes 1
  timeout 10000
else
  worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
  timeout 15
  preload_app true
end

before_fork do |_server, _worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  ActiveRecord::Base.connection.disconnect! if defined? ActiveRecord::Base
end

after_fork do |_server, _worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to sent QUIT'
  end

  if defined? ActiveRecord::Base
    config = ActiveRecord::Base.configurations[Rails.env] || Rails.application.config.database_configuration[Rails.env]
    config['reaping_frequency'] = (ENV['DB_REAPING_FREQUENCY'] || 10).to_i
    config['pool'] = (ENV['DB_POOL'] || 2).to_i
    ActiveRecord::Base.establish_connection(config)
  end
end
