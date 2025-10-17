class Admin::BoardsController < ApplicationController
  # before_action :require_admin!

  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  
  def destroy
    @board = Board.find(params[:id])
    @board.destroy!
    redirect_to admin_boards_path, success: '削除に成功しました', status: :see_other
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
