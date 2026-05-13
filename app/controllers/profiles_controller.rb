class ProfilesController < ApplicationController
  # editとupdateの前にset_userを実行
  before_action :set_user, only: %i[edit update]

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: "#{@user.name}さんのプロフィールを更新しました"
    else
      flash.now["danger"] = "プロフィール更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  # 許可するカラムの指定
  def user_params
    params.require(:user).permit(:email, :name, :image, :image_cache)
  end
end
