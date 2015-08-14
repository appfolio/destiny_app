require 'test_helper'
require 'database_cleaner'

class CastleControllerTest < ActionController::TestCase
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

  test "Gate is created when it doesn't already exist" do
    @user = FactoryGirl.create(:user_with_tables_prefix)
    sign_in @user

    get :gate

    gate = Gate.first

    assert_not_nil gate
    assert_equal "123456788", gate.tables_prefix
    assert gate.is_locked, "Gate should start off locked"
  end

  test "Letter is delivered" do
    @user = FactoryGirl.create(:user_with_tables_prefix)
    sign_in @user

    #This is done on challenges setup
    ActiveRecord::Schema.define do
      create_table "123456788_letters" do |t|
        t.string :content

        t.timestamps
      end
    end

    get :gate
    post :deliver_letter, {column:"PLEASE LET ME IN"}

    assert_not_nil Letter.first
    assert_equal "PLEASE LET ME IN", Letter.first.content

    ActiveRecord::Schema.define do
      drop_table "123456788_letters"
    end
  end

  test "Letters are deleted and gate is unlocked with correct letter after knocking" do
    @user = FactoryGirl.create(:user_with_tables_prefix)
    sign_in @user

    #This is done on challenges setup
    ActiveRecord::Schema.define do
      create_table "123456788_letters" do |t|
        t.string :content

        t.timestamps
      end
    end

    content = "<script>jQuery.ajax({type:'POST',url:'unlock_the_gate'})"

    get :gate
    post :deliver_letter, {column: content }

    assert_equal 1, Letter.all.size
    assert_equal content, Letter.first.content

    post :knock

    #knock spawns a new thread for phantom
    assert_not_nil User.where(name: "Guard", tables_prefix: "123456788")

    ActiveRecord::Schema.define do
      drop_table "123456788_letters"
    end
  end

  test "Gate is opened on push_gate action" do
    @user = FactoryGirl.create(:user_with_tables_prefix)
    sign_in @user

    content = "<script>jQuery.ajax({type:'POST',url:'unlock_the_gate'})"

    #creates gate with table prefix
    get :gate

    gate = Gate.where(tables_prefix:"123456788").first
    gate.is_locked = false
    gate.save

    post :push_gate
    assert_response 200
    resp = JSON.parse response.body
    assert_equal "success", resp["result"]
    assert_equal "Congratulations the gate is now open! You have completed the challenge section!", resp["description"]

  end

  test "Gate is not opened on push_gate action when the gate is locked" do
  end
end
