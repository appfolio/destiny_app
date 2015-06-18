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
    id = current_user.id
    unless ActiveRecord::Base.connection.table_exists? "#{id}_reference_letters"
      ActiveRecord::Schema.define do
        create_table "#{id}_reference_letters" do |t|
          t.string :content

          t.timestamps
        end
      end
    end

    set_table_name
  end

  def xss_deliver_letter
    input = params[:column]

    begin
      query = Letter.new(content: input)
      query.save
      @sql = last_sql
      hash = {
        result: "success",
        sql: @sql,
        query: "Your letter has been sent! "+
        "There are #{Letter.all.size} letter(s) in the inbox."
      }
      render text: hash.to_json
    rescue => e
      @error = e
      @sql = last_sql
      render partial: "references/query_error"
    end
  end

  def xss_read_letters
    @letters = Letter.destroy_all
  end

  def mass_assignment
    @refs = MassAssignments
    if params[:ref_num]
      ref_num = params[:ref_num].to_i

      unless ref_num.between?(0,MassAssignments.size-1)
        flash[:error] = "That page does not exist"
        redirect_to references_mass_assignments_path
      end

      @ref = MassAssignments[ref_num]
      @ref_num = ref_num
    else
      @ref = MassAssignments[0]
      @ref_num = 0
    end
  end

  def mass_assignment_create_chest
    #TODO these could be re-written to be a method
    #that accepts a block, yield to what query to run
    #look for returned value of the query
    begin
      chest = Chest.create(params)
      @sql = last_sql
      render partial: "query_result", object: chest
    rescue => e
      @error = e
      @sql = last_sql
      render partial: "query_error"
    end
  end

  MassAssignments.each do |ma|
    ReferencesController.class_eval <<-RUBY
      def safe_#{ma[:name]}
        begin
          #{ma[:safe_code]}
          @sql = last_sql
          render partial: "query_result", object: chest
        rescue => e
          @error = e
          @sql = last_sql
          render partial: "query_error"
        end

        reset_db
      end

      def vulnerable_#{ma[:name]}
        begin
          #{ma[:vuln_code]}
          @sql = last_sql
          render partial: "query_result", object: chest
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
