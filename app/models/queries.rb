#Assumption is that everything in this file is html_safe
#
Queries = [
  {
    input_form: {action_url: :where},
    output: "query.to_a",
    name: "Where method",
    link: "http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-where",
    query: 'Chest.where("size = \'#{params[:column]}\'")',
    hint: {
      input: {name: "params[:column]", example: ["') OR '1'='1", "Large') UNION select id, email, encrypted_password, name, mobile_number from users where ('1'='1"]},
      text: "This example returns all records, and the union query returns user information."
    },
    footer: {
      sources: ["http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-where",
                "https://dev.mysql.com/doc/refman/5.1/en/comments.html"],
      description: <<-CODE
def exec_sqli
  # Safe usages of where method
  output = Chest.where(size: params[:column])
  output = Chest.where("size = ?", params[:column])

  # Unsafe usage of where method
  output = Chest.where("size = '\#{params[:column]}'")

  render text: output.to_a
end
    CODE
    },
    desc: <<-HTML
          Some information provided by other websites regarding sql injection is
          not relevant to rails. Specifically you can't insert ';' into Active
          Record method calls and have multiple queries executed in that single
          method call. However, you can still use comment delimiters like '#'
          and '-- ' for mysql to comment out the rest of the query. Make sure you
          parameterize your input to every Active Record method, or use a hash
          to pass in values. See the countermeasures code.
    HTML
  },

  {
    input_form: {action_url: :calculate},
    output: "query",
    name: "Calculate method",
    link: "http://api.rubyonrails.org/classes/ActiveRecord/Calculations.html#method-i-calculate",
    query: 'Chest.calculate(:sum, "#{params[:column]}")',
    hint: {
      input: {name: "params[:column]. This will allow a read from the users table.",
              example: ["'id') AS sum_id FROM users#"]}
    },
    footer: {
      sources: ["http://api.rubyonrails.org/classes/ActiveRecord/Calculations.html#method-i-calculate",
                "https://dev.mysql.com/doc/refman/5.1/en/grant.html"],
      description: <<-CODE
def exec_sqli
  # Unsafe use of calculate method
  output = Chest.calculate(:sum, '\#{params[:column]}')

  render text: output.to_a
end
    CODE
    },
    desc: <<-HTML
      The calculate method will not santize a query string passed in. You can
      use sql injection to access unauthorized information. It is a little more
      limited than the where command, the idea here is to change the
      data you are doing calculations on. Depending on the DB user priviledges
      you can read data from other tables.
    HTML
  },

  {
    input_form: {action_url: :delete_all},
    output: "query",
    name: "delete_all method",
    link: "http://api.rubyonrails.org/classes/ActiveRecord/Relation.html#method-i-delete_all",
    query: 'Chest.delete_all("id = #{params[:id]}") unless params[:id].include? "users"'+
    "\r#Can't have you messing with the users table :)\r#you might kick yourself and everyone else off",
    hint: {
      input: {name: "params[:id]. This will all records in the table.",
              example: ["'id') AS sum_id FROM users#"]}
    },
    footer: {
      sources: ["http://api.rubyonrails.org/classes/ActiveRecord/Relation.html#method-i-delete_all",
                "http://stackoverflow.com/questions/1233451/delete-from-two-tables-in-one-query",
                "http://www.codeproject.com/KB/database/Visual_SQL_Joins/Visual_SQL_JOINS_orig.jpg",
                "http://guides.rubyonrails.org/association_basics.html#why-associations-questionmark"],
      description: <<-CODE
def exec_sqli
  # Unsafe use of delete_all method
  output = Chest.delete_all("id = \#{params[:id]}")

  # Safe usage of delete_all method
  output = Chest.delete_all("id = ?", params[:id])
  render text: output.to_a
end
    CODE
    },
    desc: <<-HTML
      The delete_all method will not santize a query string passed in. This method
      also does not run callbacks like destroy_all does. This can easily cause issues
      in an application with models that have has_many relationships that are left with
      id's that don't associate with anything. Cross table deletion can occur
      here with proper use of joins.
    HTML
  }
]
