class PagesController < ApplicationController
  skip_before_action :require_login, only: %i[terms]

  # 表示するための空のアクション
  def terms; end
end
