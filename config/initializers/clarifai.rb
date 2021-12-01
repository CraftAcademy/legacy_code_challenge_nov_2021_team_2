Clarifai::Rails.setup do |config|
  config.api_key = Rails.application.credentials[:clarifai_key]
  config.model_code = 'd16f390eb32cad478c7ae150069bd2c6'
end
