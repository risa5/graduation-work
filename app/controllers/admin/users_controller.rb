class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :asc).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit;
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), success: t('defaults.flash_message.updated', item: User.name)
    else
      flash.now['danger'] = t('defaults.flash_message.not_updated', item: User.name)
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to admin_users_path, success: '削除に成功しました', status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :role, :image, :image_cache)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
