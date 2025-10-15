class Admin::UsersController < ApplicationController
  # before_action :require_admin!

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :asc).page(params[:page])
    # @users = User.order(created_at: :asc).page(params[:page])
  end
end
