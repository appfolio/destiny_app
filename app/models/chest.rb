class Chest < ActiveRecord::Base
  has_one :item, dependent: :destroy

  def unlock_with key
    if self.key_slot == Digest::SHA1.hexdigest(key)
      return self.item
    else
      raise "Incorrect Key"
    end
  end

  def to_str
    "#{size} #{color} chest"
  end
end
