class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

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


  private

  def user_params
    params.require(:user).permit(:email, :name, :image, :image_cache)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
