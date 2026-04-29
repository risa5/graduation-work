class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    remember_flag = ActiveModel::Type::Boolean.new.cast(params[:remember]) 
    @user = login(params[:email], params[:password], remember_me: remember_flag)

    if @user
      redirect_to user_role_path(@user), success: t("user_sessions.create.success")
    else
      flash.now[:danger] = t("user_sessions.create.failure")
      render :new, status: :unprocessable_entity
    end
  end

  def user_role_path(user)
    case user.role
    when 'admin'
      admin_root_path
    when 'general'
      root_path
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, success: t('user_sessions.destroy.success')
  end
end