#Queries defined in models/queries.rb
Queries.each do |q|
  SqlInjectionController.class_eval <<-RUBY
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
