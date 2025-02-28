class BoardsController < ApplicationController
  def index
    @boards = Board.includes(:user)
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, success: '作成しました'
    else
      flash.now[:danger] = '作成できませんでした'
      render :new, status: :unprocessable_entity
    end
  end
  
  def show
    @board = Board.find(params[:id])
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      redirect_to board_path(@board), success: '更新に成功しました'
    else
      flash.now[:danger] = '更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    board = current_user.boards.find(params[:id])
    board.destroy!
    redirect_to boards_path, success: '削除に成功しました', status: :see_other
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
