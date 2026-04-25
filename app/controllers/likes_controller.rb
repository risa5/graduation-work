class LikesController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    current_user.likes.create(board: @board)
  end

  def destroy
    @board = Board.find(params[:board_id])
    current_user.likes.find_by(board: @board)&.destroy
  end
end