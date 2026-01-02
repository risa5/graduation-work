class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top]

  # トップページの表示アクション
  def top; end
end

