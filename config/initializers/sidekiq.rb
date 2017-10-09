require 'sidekiq'

Sidekiq.configure_server do |config|
  config.redis = { namespace: "blog_#{ ENV['RAILS_ENV'] }" }
end

Sidekiq.configure_client do |config|
  config.redis = { namespace: "blog_#{ ENV['RAILS_ENV'] }" }
end
