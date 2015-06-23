Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

class Rack::Attack
  # your custom configuration...
  throttle('sqli_actions', :limit => 20, :period => 10.seconds) do |req|
    throttled_actions = %w( where calculate delete_all destroy_all )
    req.ip if throttled_actions.any? {|action| req.path.include? action }
  end
end
