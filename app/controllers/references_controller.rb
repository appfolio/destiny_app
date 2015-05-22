class ReferencesController < ApplicationController
  def index
  end

  def sqli
  end

  def exec_sqli
    Chest.calculate(:sum, params[:column])
  end
end
