Queries.each do |q|
  ReferencesController.class_eval <<-RUBY
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
