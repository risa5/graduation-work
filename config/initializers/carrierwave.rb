CarrierWave.configure do |config|
  config.storage = :file unless Rails.env.production?
end
