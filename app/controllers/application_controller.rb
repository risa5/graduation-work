class ApplicationController < ActionController::Base
  # すべてのコントローラーのアクションが実行される前に `require_login` を適用
  # これにより、ログインしていないユーザーはアクセスできなくなる
  include MetaTags::ControllerHelper
  before_action :require_login

  add_flash_types :success, :danger

  private

  # ユーザーが認証されていない（ログインしていない）場合の処理
  # `sorcery` の `require_login` によってログイン必須のアクションに適用される
  # ログインしていない場合は `login_path` にリダイレクトさせる
  def not_authenticated
    redirect_to login_path, danger: 'ログインが必要です'
  end

  def prepare_meta_tags(result)
    # ✅ OGP画像のURL：まずは絶対URL文字列を用意（動的生成の有無に応じて差し替え）
    # 1) 先に静的な暫定画像（public/ogp_default.png）でOKにしておき、
    # 2) あとで MiniMagick の動的画像URLに差し替えるのが安全です。
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
      # 省略可能（必要なら残す）
      twitter: {
        card:  'summary_large_image',
        image: image_url
      }
    )
  end
end
