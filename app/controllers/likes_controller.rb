class LikesController < ApplicationController
  def create
    @like = Like.new(user_id: current_user.id, board_id: params[:board_id])
    @like.save
    redirect_to board_path(params[:board_id]) 
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, board_id: params[:board_id])
    @like.destroy
    redirect_to board_path(params[:board_id]) 
  end
end