class ImageUploader < CarrierWave::Uploader::Base

  if Rails.env.production?
    include Cloudinary::CarrierWave
    storage :fog
  else
    storage :file
  end

  def default_url
    ActionController::Base.helpers.asset_path("sample.jpg")
  end

  def extension_allowlist
    %w[jpg jpeg gif png]
  end
end
