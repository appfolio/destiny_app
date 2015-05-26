class Chest < ActiveRecord::Base
  def to_str
    "#{size} #{color} chest"
  end
end
