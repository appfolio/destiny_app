class ReferencesController < ApplicationController
  before_action :set_table_name

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

  def xss
  end

  def xss_visit_page
    load File.join(Rails.root, "lib/gate_guard.rb")

    GateGuard::sign_in request

    render text: "Signing in"
  end

  Queries.each do |q|
    class_eval <<-RUBY
      def #{q[:input_form][:action_url]}
        begin
          query = #{q[:query]}
          result = #{q[:output]}
          @sql = last_sql
          render partial: "query_result", object: result
        rescue => e
          @error = e
          @sql = last_sql
          render partial: "query_error"
        end

        reset_db
      end
    RUBY
  end

  private

  def within_queries_range num
    num.is_a?(Fixnum) && num > -1 && num < Queries.size
  end
end
