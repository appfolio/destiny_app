class Chest < ActiveRecord::Base
  has_one :item, dependent: :destroy

  def to_str
    "#{size} #{color} chest"
  end
end
