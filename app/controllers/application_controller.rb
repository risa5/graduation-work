class ApplicationController < ActionController::Base
  # すべてのコントローラーのアクションが実行される前に `require_login` を適用
  # これにより、ログインしていないユーザーはアクセスできなくなる
  before_action :require_login

  add_flash_types :success, :danger

  private

  # ユーザーが認証されていない（ログインしていない）場合の処理
  # `sorcery` の `require_login` によってログイン必須のアクションに適用される
  # ログインしていない場合は `login_path` にリダイレクトさせる
  def not_authenticated
    redirect_to login_path
  end
end
