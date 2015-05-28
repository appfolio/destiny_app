if not defined? ActiveRecord::ConnectionAdapters::AbstractAdapter
  abort "Need to be able to override AbstractAdapter log"
end

class ActiveRecord::ConnectionAdapters::AbstractAdapter
  alias oldlog log

  @@counter = 0
  def log sql, *args, &block
    $last_sql = sql unless sql.include? "SHOW"
    @@counter+=1

    puts "#{@@counter}: #{$last_sql}"

    oldlog sql, *args, &block
  end
end
