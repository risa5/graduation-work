class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: t('defaults.flash_message.updated', item: User.name)
    else
      flash.now['danger'] = t('defaults.flash_message.not_updated', item: User.name)
      render :edit, status: :unprocessable_entity
    end
  end

  def show; end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:email, :name, :image, :image_cache)
  end
end