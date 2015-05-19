class HomeController < ApplicationController
  filter_access_to :all
  def index
    @current_user = current_user
  end
end
