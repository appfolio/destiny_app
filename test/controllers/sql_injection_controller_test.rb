require 'test_helper'

class SqlInjectionControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "should have default table names" do
    user = FactoryGirl.create(:user)
    sign_in user

    get :index
    assert_response :success
    assert_not_nil assigns(:current_user)
    assert_equal "chests", Chest.table_name
    assert_equal "items", Item.table_name
    assert_equal "key_cards", KeyCard.table_name
    assert_equal "#{user.id}_reference_letters", Letter.table_name
  end
end
