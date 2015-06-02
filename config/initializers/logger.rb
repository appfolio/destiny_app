if not defined? ActiveRecord::ConnectionAdapters::AbstractAdapter
  abort "Need to be able to override AbstractAdapter log"
end

class ActiveRecord::ConnectionAdapters::AbstractAdapter
  alias oldlog log

  def log sql, *args, &block
    #maybe a lambda could be used to compare an array of unwanted strings
    $last_sql = sql unless sql.include?("SHOW") || sql.include?("COMMIT")

    oldlog sql, *args, &block
  end
end
