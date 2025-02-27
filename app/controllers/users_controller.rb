class UsersController < ApplicationController
    # `require_login` をスキップし、新規登録 (`new, create`) は未ログインでもアクセスできるようにする
    skip_before_action :require_login, only: %i[new create]
  
    # ユーザー新規登録画面を表示するアクション
    def new
      # フォーム用に空の `User` オブジェクトを作成
      @user = User.new
    end
  
    # ユーザー登録を処理するアクション
    def create
      # フォームから送信されたデータを元に `User` オブジェクトを作成
      @user = User.new(user_params)
      # バリデーションを通過すればデータベースに保存
      if @user.save
        redirect_to root_path, success: t('users.create.success')
      else
       # 登録失敗時は新規登録フォームを再表示（エラーメッセージ付き）
       flash.now[:danger] = t('users.create.failure')
       render :new, status: :unprocessable_entity
      end
    end
    
    private
  
    # ストロングパラメータ（セキュリティ対策）
    # `params[:user]` の中から、許可された値のみを受け取る
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end
  