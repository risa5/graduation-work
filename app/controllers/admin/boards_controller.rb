class Admin::BoardsController < ApplicationController
  before_action :set_board, only: %i[show edit update destroy]

  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end
  
  def destroy
    @board = Board.find(params[:id])
    @board.destroy!
    redirect_to admin_boards_path, success: '削除に成功しました', status: :see_other
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    if @board.update(board_params)
      redirect_to admin_board_path(@board), success: t('defaults.flash_message.updated', item: Board.name)
    else
      flash.now['danger'] = t('defaults.flash_message.not_updated', item: Board.name)
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end

  def set_board
    @board = Board.find(params[:id])
  end
end
