class GoogleLoginApiController < ApplicationController
  require 'googleauth/id_tokens/verifier'

  # ログイン前にcallbackにアクセス可能
  skip_before_action :require_login, only: :callback
  # CSRF対策をスキップ
  skip_forgery_protection only: :callback
  # Google用CSRF対策を実行
  before_action :verify_g_csrf_token, only: :callback

  def callback
    # Googleからのデータ取得
    user_info = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: '934784863584-07bc30bi7qd21in005c81pf4023f3lgq.apps.googleusercontent.com')

    # Google認証済みユーザーか確認
    user = User.find_by(provider: "google", provider_uid: user_info["sub"])
    # Google認証済みでなければ新しくインスタンス作成
    user ||= User.new

    user.email = user_info["email"]
    user.name = user_info["name"]
    user.provider = "google"
    user.provider_uid = user_info["sub"]
    user.provider_image = user_info["picture"]
    user.role ||= :general

    user.save!

    session[:user_id] = user.id
    redirect_to user_role_path(user), success: t("user_sessions.create.success")

    # save!に失敗した場合の例外処理
    rescue StandardError => e
    Rails.logger.error("Google login failed: #{e.class} #{e.message}")
    redirect_to google_failed_path, danger: t("user_sessions.create.failure")
  end

  private

  # 権限判別
  def user_role_path(user)
    case user.role
    when 'admin'
      admin_root_path
    when 'general'
      root_path
    end
  end

  def google_failed_path
    case params[:state]
    when "register"
      new_user_path
    else
      login_path
    end
  end
  
  # Google用CSRF対策
  def verify_g_csrf_token
    if cookies["g_csrf_token"].blank? ||
      params[:g_csrf_token].blank? ||
      cookies["g_csrf_token"] != params[:g_csrf_token]

      redirect_to google_auth_failed_redirect_path, danger: "不正なアクセスです"
    end
  end
