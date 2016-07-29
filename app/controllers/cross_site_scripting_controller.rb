class CrossSiteScriptingController < ApplicationController
  before_action :set_table_name
  include ShieldsUp

  def index
  end

  def deliver_letter
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

  def read_letters
    @letters = Letter.destroy_all
  end
end
