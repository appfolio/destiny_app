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

  test "assigns the user's unique table name when tables_prefix is present" do
    sign_in FactoryGirl.create(:user_with_tables_prefix)

    get :index
    assert_response :success
    assert_not_nil assigns(@user)
    assert_equal "123456788_chests", Chest.table_name
    assert_equal "123456788_items", Item.table_name
    assert_equal "123456788_key_cards", KeyCard.table_name
    assert_equal "123456788_letters", Letter.table_name
  end

  test "assigns the default table name when tables_prefix is absent" do
    user = FactoryGirl.create(:user)
    sign_in user

    get :index
    assert_response :success
    assert_not_nil assigns(@user)
    assert_equal "chests", Chest.table_name
    assert_equal "items", Item.table_name
    assert_equal "key_cards", KeyCard.table_name
    assert_equal "#{user.id}_reference_letters", Letter.table_name
  end

  test "generates and seeds challenge tables when tables_prefix is absent" do
    @user = FactoryGirl.create(:user)
    sign_in @user


    #stub out generation of tables_prefix
    def SecureRandom.uuid; "123456788"; end

    post :setup_challenge_environment

    # Grab user now that tables_prefix should be set
    @user.reload

    msg = "Tables not prefixed correctly"
    assert_equal "123456788", @user.tables_prefix, msg
    assert_equal "123456788_chests", Chest.table_name, msg
    assert_equal "123456788_items", Item.table_name, msg
    assert_equal "123456788_key_cards", KeyCard.table_name, msg
    assert_equal "123456788_letters", Letter.table_name, msg

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
  end

  # Loading fixtures was causing the mysql error
  test "does not generate challenge tables when tables_prefix is present" do
    def set_table_name; ;end

    @user = FactoryGirl.create(:user_with_tables_prefix)
    sign_in @user

    post :setup_challenge_environment

    hash = JSON.parse response.body

    assert_not_nil @user.tables_prefix
    assert_equal "Failure", hash["result"]
    assert_equal "Your environment is already set up.", hash["description"]
    assert_response 200
  end
end
