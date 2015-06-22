class SqlInjectionController < ApplicationController
  before_action :set_table_name
  include ShieldsUp

  #metaprogrammed actions defined in config/initializers/references.rb

  def index
  end

  def sqli
    if params[:ref_num]
      ref_num = params[:ref_num].to_i

      unless within_queries_range ref_num
        flash[:error] = "That page does not exist"
        redirect_to references_sqli_path
      end

      @query = Queries[ref_num]
      @ref_num = ref_num
    else
      @query = Queries[0]
      @ref_num = 0
    end
  end

  private

  def within_queries_range num
    num.is_a?(Fixnum) && num > -1 && num < Queries.size
  end
end
