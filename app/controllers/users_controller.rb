class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      auto_login(@user)
      redirect_to user_role_path(@user), success: t('users.create.success')
    else
      flash.now[:danger] = t('users.create.failure')
      render :new, status: :unprocessable_entity
    end
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

  # 許可するカラムの指定
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
