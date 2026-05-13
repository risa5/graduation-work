# 開発環境ではローカルに保存
CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = "fog/cloudinary"
  else
    config.storage = :file
  end
end
