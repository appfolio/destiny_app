class MassAssignmentController < ApplicationController
  before_action :set_table_name
  include ShieldsUp

  #MassAssignments defined in models/mass_assignments.rb
  MassAssignments.each do |ma|
    MassAssignmentController.class_eval <<-RUBY
      def safe_#{ma[:name]}
        begin
      #{ma[:safe_code]}
          @sql = last_sql
          render partial: "sql_injection/query_result", object: @chest
        rescue => e
          @error = e
          @sql = last_sql
          render partial: "sql_injection/query_error"
        end

        reset_db
      end

      def vulnerable_#{ma[:name]}
        begin
      #{ma[:vuln_code]}
          @sql = last_sql
          render partial: "sql_injection/query_result", object: @chest
        rescue => e
          @error = e
          @sql = last_sql
          render partial: "sql_injection/query_error"
        end

        reset_db
      end
      RUBY
  end

  def ma
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
      render partial: "sql_injection/query_result", object: chest
    rescue => e
      @error = e
      @sql = last_sql
      render partial: "sql_injection/query_error"
    end
  end
end
