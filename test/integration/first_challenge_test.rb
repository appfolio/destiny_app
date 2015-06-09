require 'test_helper'
require 'database_cleaner'

class ChallengesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  self.use_transactional_fixtures = false
  DatabaseCleaner.logger = Rails.logger
  DatabaseCleaner.strategy = :deletion, { cache_tables: false }
  DatabaseCleaner.clean_with :deletion

  def setup
    DatabaseCleaner.start
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  def teardown
    #generated tables will still be present, but that's ok because they
    #get dropped when a new test db is created
    DatabaseCleaner.clean
  end

  test "unlocks all chests properly" do
    @user = FactoryGirl.create(:user)
    sign_in @user

    #stub out generation of tables_prefix
    def SecureRandom.uuid; "haha"; end

    post :setup_challenge_environment

    # Grab user now that tables_prefix should be set
    @user.reload

    msg = "Tables not prefixed correctly"
    assert_equal "HAHA", @user.tables_prefix, msg
    assert_equal "HAHA_chests", Chest.table_name, msg
    assert_equal "HAHA_items", Item.table_name, msg
    assert_equal "HAHA_key_cards", KeyCard.table_name, msg

    msg = "Not seeding correctly"
    assert_equal "Large", Chest.first.size, msg
    assert_equal "Green", Chest.first.color, msg
    assert_equal Item.first, Chest.first.item, msg
    assert_equal "Medium", Chest.last.size, msg
    assert_equal "Brown", Chest.last.color, msg
    assert_equal Item.last, Chest.last.item, msg
    assert_equal "Small", Chest.find(2).size, msg
    assert_equal "Purple", Chest.find(2).color, msg
    assert_nil Chest.find(2).item, msg
    assert_response 200

    get :start

    Chest.all.zip(KeyCard.all).each do |chest, key|
      params = {
        column: key.blade,
        id: chest.id
      }

      post :unlock_chest_with, params

      hash = JSON.parse response.body

      assert_equal "success", hash["result"]
      if chest.item
        assert hash["query"].include?(chest.item.token), "didn't grab correct token"
      else
        assert_equal "null", hash["query"]
      end
    end
  end
end


















