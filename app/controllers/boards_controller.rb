class BoardsController < ApplicationController
  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true)
                .includes(:user)
                .order(created_at: :desc)
                .page(params[:page])
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
    @comment = Comment.new
    @comments = @board.comments
                      .includes(:user)
                      .order(created_at: :desc)
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

  def bookmarks
    @q = current_user.bookmark_boards.ransack(params[:q])
    @bookmark_boards = @q.result(distinct: true)
                          .includes(:user)
                          .order(created_at: :desc)
                          .page(params[:page])
  end

  def autocomplete
    keyword = params[:keyword].to_s.strip
    field = params[:field]

    return render inline: "" if keyword.blank?

    labels =
      case field
      when "title"
        Board.where("title LIKE ?", "%#{keyword}%").distinct.limit(10).pluck(:title)
      when "body"
        Board.where("body LIKE ?", "%#{keyword}%").distinct.limit(10).pluck(:body)
      else
        []
      end

    render partial: "autocomplete", locals: { labels: labels }
  end

  private

  # 許可するカラムの指定
  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end
end
