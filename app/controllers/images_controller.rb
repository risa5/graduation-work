class ImagesController < ApplicationController
  def ogp
    text = ogp_params[:text]
    image = OgpCreator.build(text).tempfile.open.read
    send_data image, type: 'image/png', disposition: 'inline'
  end

  private

  # 許可するカラムの指定
  def ogp_params
    params.permit(:text)
  end
end
