class StaticPagesController < ApplicationController
  # `require_login` をスキップし、未ログインユーザーでも `top` アクションにアクセスできるようにする
  skip_before_action :require_login, only: %i[top]

  # トップページ（ルートページ）の表示アクション
  def top; end
  # 空のメソッド（`top.html.erb` のビューを表示するだけ）
end

