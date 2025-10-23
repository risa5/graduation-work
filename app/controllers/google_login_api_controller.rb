class GoogleLoginApiController < ApplicationController
  require 'googleauth/id_tokens/verifier'

  skip_before_action :require_login, only: :callback
  skip_forgery_protection only: :callback
  protect_from_forgery except: :callback
  before_action :verify_g_csrf_token

  def callback
    payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: '811707880125-2sm1k1amvipajslkhgrgnr5aet02ta68.apps.googleusercontent.com')
    user = User.find_or_create_by(email: payload['email'])
    session[:user_id] = user.id
    redirect_to user_role_path(@user), success: 'ログインしました'
  end


  def user_role_path(user)
    case user.role
    when 'admin'
      admin_root_path
    when 'general'
      root_path
    end
  end

  private

  def verify_g_csrf_token
    if cookies["g_csrf_token"].blank? || params[:g_csrf_token].blank? || cookies["g_csrf_token"] != params[:g_csrf_token]
      flash.now[:danger] = 'ログインに失敗しました'
      render :new, status: :unprocessable_entity
    end
  end
end
