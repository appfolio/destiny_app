#Assumption is that everything in this file is html_safe
#
Queries = [
  {
    input_form: {action_url: :where},
    output: "query.to_a",
    name: "where method",
    link: "http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-where",
    query: 'Chest.where("size = \'#{params[:column]}\'")',
    hint: {
      input: {name: "params[:column]", example: ["') OR ('1'='1", "Large') UNION select id, email, encrypted_password, name, mobile_number from users where ('1'='1"]},
      text: "This example returns all records, and the union query returns user information."
    },
    footer: {
      sources: ["http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-where",
                "https://dev.mysql.com/doc/refman/5.1/en/comments.html"],
      description: <<-CODE
def exec_sqli
  # Safe usages of where method. It is recommended to use
  # one of these two ways to sanitize input.
  output = Chest.where(size: params[:column])
  output = Chest.where("size = ?", params[:column])

  # Unsafe usages of where method
  output = Chest.where("size = '\#{params[:column]}'")

  # Still unsafe, 1=1 will cause all records from the model's
  # table to be shown. Good example of where sanitizing
  # does not always protect you. Be explicit on what columns
  # are to be checked like on line 18.
  output = Chest.where(ActiveRecord::Base::sanitize(params[:column]))

  # this way is safer, placing user input into quotes
  # for the value of size in the where clause.
  output = Chest.where("size = \#{ActiveRecord::Base::sanitize(params[:column])}")

  render text: output.to_a
end
    CODE
    },
    desc: <<-HTML
          Some information provided by other websites regarding sql injection is
          not relevant to rails. Specifically you can't insert ';' into Active
          Record method calls and have multiple queries executed in that single
          method call (AKA query stacking).
          However, you can still use comment delimiters like '#'
          and '-- ' for mysql to comment out the rest of the query. Make sure you
          parameterize your input to every Active Record method, or use a hash
          to pass in values. See the countermeasures code.
    HTML
  },

  {
    input_form: {action_url: :calculate},
    output: "query",
    name: "calculate method",
    link: "http://api.rubyonrails.org/classes/ActiveRecord/Calculations.html#method-i-calculate",
    query: 'Chest.calculate(:sum, params[:column])',
    hint: {
      input: {name: "params[:column]. This will allow a read from the users table.",
              example: ["`id`) AS sum_id FROM `users`#","id) from users#"]}
    },
    footer: {
      sources: ["http://api.rubyonrails.org/classes/ActiveRecord/Calculations.html#method-i-calculate",
                "https://dev.mysql.com/doc/refman/5.1/en/grant.html"],
      description: <<-CODE
def exec_sqli
  # Unsafe use of calculate method
  output = Chest.calculate(:sum, "\#{params[:column]}")
  output = Chest.calculate(:sum, params[:column])

  # Not sufficient, quoting out input only throws sql syntax error
  output = Chest.calculate(:sum, "\#{ActiveRecord::Base::sanitize(params[:column])}")

  # Safe use of calculate method
  # Do not put user input in this method call
  output = Chest.calculate(:sum, "id")
  output = Chest.calculate(:sum, :id)

  render text: output.to_a
end
    CODE
    },
    desc: <<-HTML
      The calculate method will not santize a query string passed in. You can
      use sql injection to access unauthorized information. It is a little more
      limited than the where command, the idea here is to change the
      data you are doing calculations on. Depending on the DB user priviledges
      you can read data from other tables and databases.
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
      input: {name: "params[:id]. This will delete all records in the table.",
              example: ["1 OR 1=1", "1 OR 1=1)--&nbsp;".html_safe]}
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
      in an application with models that have references that are left with
      id's that don't associate with anything. Depending on the query's structure
      cross table deletion could occur with the proper use of joins.
    HTML
  },

  {
    input_form: {action_url: :destroy_all},
    output: "query",
    name: "destroy_all method",
    link: "http://api.rubyonrails.org/classes/ActiveRecord/Relation.html#method-i-destroy_all",
    query: 'Chest.destroy_all(id = "#{params[:id]}") unless params[:id].include? "users"',
    hint: {
      input: {name: "params[:id]",
              example: ["1 OR 1=1"]}
    },
    footer: {
      sources: [],
      description: <<-CODE
def exec_sqli
  # Unsafe use of destroy_all method
  output = Chest.destroy_all("id = \#{params[:id]}")
  output = Chest.destroy_all("id = \#{ActiveRecord::Base::sanitize(params[:id])}")

  # Safe usage of destroy_all method
  output = Chest.destroy_all(id: "\#params[:id]")

  render text: output.to_a
end
    CODE
    },
    desc: <<-HTML
      The destroy_all method will not santize a query string passed in. Records
      are gathered from the database in a SELECT to have their callbacks ran,
      and then are deleted. The countermeasures here are the same as for most
      queries.
    HTML
  }]
