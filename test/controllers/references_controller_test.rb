require 'test_helper'

class ReferencesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in FactoryGirl.create(:user)
  end

  test "should have default table names" do
    get :index
    assert_response :success
    assert_not_nil assigns(@user)
    assert_equal "chests", Chest.table_name
    assert_equal "items", Item.table_name
  end
end
