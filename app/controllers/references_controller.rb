class ReferencesController < ApplicationController
  def index
  end

  def sqli
  end

  def exec_sqli
    output = Chest.where("size = '#{params[:column]}'")

    render text: output.to_a
  end
end
