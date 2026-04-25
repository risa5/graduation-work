class PagesController < ApplicationController
  skip_before_action :require_login, only: %i[terms]

  def terms; end
end
