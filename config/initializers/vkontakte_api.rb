VkontakteApi.configure do |config|
  config.app_id       = Rails.application.secrets.vk_app_id
  config.app_secret   = Rails.application.secrets.vk_app_secret

  config.max_retries = 2

  config.logger        = Rails.logger
  config.log_requests  = true
  config.log_errors    = true
  config.log_responses = false

  config.api_version = '5.21'
end
