class UserSessionsController < ApplicationController
  # `require_login` をスキップし、未ログインユーザーでも `new`（ログインフォーム表示）と `create`（ログイン処理）が実行できるようにする
  skip_before_action :require_login, only: %i[new create]

  # ログインフォームを表示するアクション
  def new;
  # 何も処理せず、対応するビュー（`new.html.erb`）を表示する
  end

  # ログイン処理を行うアクション
  def create
    # `sorcery` の `login` メソッドを使用して、入力された `email` と `password` で認証を試みる
    @user = login(params[:email], params[:password])

    if @user
      # ログイン成功時はトップページへリダイレクト
      redirect_to root_path, success: 'ログインしました'
    else
      # ログイン失敗時は `new.html.erb` を再表示（エラーメッセージを表示できる）
      flash.now[:danger] = 'ログインに失敗しました'
      render :new, status: :unprocessable_entity
    end
  end

  # ログアウト処理を行うアクション
  def destroy
    logout
    redirect_to root_path, status: :see_other, success: t('user_sessions.destroy.success')
  end
end