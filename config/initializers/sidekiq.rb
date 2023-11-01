require 'sidekiq/api'

Sidekiq.configure_server do |config|
  config.redis = { url: REDIS_URL, network_timeout: 3 }
  Rails.logger = Sidekiq.logger
  ActiveRecord::Base.logger = Sidekiq.logger
end

Sidekiq.configure_client do |config|
  config.redis = { url: REDIS_URL, network_timeout: 3 }
end
