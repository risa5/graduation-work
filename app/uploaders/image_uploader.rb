class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def default_url
    ActionController::Base.helpers.asset_path('sample.jpg')
  end

  def extension_allowlist
    %w[jpg jpeg gif png]
  end

end