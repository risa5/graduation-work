class ApplicationController < ActionController::Base
  include MetaTags::ControllerHelper
  before_action :require_login
  add_flash_types :success, :danger

  private

  def not_authenticated
    redirect_to login_path, danger: 'ログインが必要です'
  end

  def prepare_meta_tags(result)
    image_url = "#{request.base_url}/ogp/diagnoses/#{params[:id]}.png"

    set_meta_tags(
      og: {
        site_name: 'HealScan',
        title:     result.pattern_code,
        description: result.result_summary.to_s,
        type:      'website',
        url:       request.original_url,
        image:     image_url,
        locale:    'ja-JP'
      },
      twitter: {
        card:  'summary_large_image',
        image: image_url
      }
    )
  end
end
