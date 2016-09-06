Sidekiq.configure_client do |config|
  config.redis = {size: :max_clients}
end
Sidekiq.configure_server do |config|
  #no redis settings
end
