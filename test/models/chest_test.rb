require 'test_helper'

class ChestTest < ActiveSupport::TestCase
  test "unlocks with correct key" do
    Chest.table_name = "chests"
    Item.table_name = "items"
    KeyCard.table_name = "key_cards"

    blade = SecureRandom.uuid.gsub('-','').upcase
    key_hole = Digest::SHA1.hexdigest(blade)

    c = Chest.create({
      size: 'Large',
      color: 'Green',
      key_slot: key_hole,
      item: Item.create
    })

    assert_equal Item.first, c.unlock_with(blade)
  end
end
