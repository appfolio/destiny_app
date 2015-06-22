require 'test_helper'

class ReferencesControllerTest < ActionController::TestCase
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

  test "mass assignment without strong parameters is vulnerable" do
    user = FactoryGirl.create(:user)
    sign_in user

    get :index
    assert_equal "#{user.id}_reference_letters", Letter.table_name, "Table name is not correct"

    post :vulnerable_wosp, chest:{size:"Large",color:"Orange",key_slot:"blarg"}
    assert_not_nil assigns(:chest), "Chest is not getting assigned as an instance variable in the controller"
    assert_equal "blarg", assigns(:chest)[:key_slot], "key_slot was not mass assigned"
  end

  test "mass assignment without strong parameters is safe" do
    user = FactoryGirl.create(:user)
    sign_in user

    get :index
    assert_equal "#{user.id}_reference_letters", Letter.table_name, "Table name is not correct"

    post :safe_wosp, chest:{size:"Large",color:"Orange",key_slot:"blarg"}
    assert_not_nil assigns(:chest), "Chest is not getting assigned as an instance variable in the controller"
    assert_nil assigns(:chest)[:key_slot]
  end

  test "mass assignment with Strong Parameters is vulnerable" do
    user = FactoryGirl.create(:user)
    sign_in user

    get :index
    assert_equal "#{user.id}_reference_letters", Letter.table_name, "Table name is not correct"

    post :vulnerable_wsp, chest:{size:"Large",color:"Orange",key_slot:"blarg"}
    assert_not_nil assigns(:chest), "Chest is not getting assigned as an instance variable in the controller"
    assert_equal "blarg", assigns(:chest)[:key_slot], "key_slot was not mass assigned"
  end

  test "mass assignment with Strong Parameters is safe" do
    user = FactoryGirl.create(:user)
    sign_in user

    get :index
    assert_equal "#{user.id}_reference_letters", Letter.table_name, "Table name is not correct"

    post :safe_wsp, chest:{size:"Large",color:"Orange",key_slot:"blarg"}
    assert_not_nil assigns(:chest), "Chest is not getting assigned as an instance variable in the controller"
    assert_nil assigns(:chest)[:key_slot]
  end

  test "mass assignment with Shields Up parameters is vulnerable" do
    user = FactoryGirl.create(:user)
    sign_in user

    get :index
    assert_equal "#{user.id}_reference_letters", Letter.table_name, "Table name is not correct"

    post :vulnerable_wsu, chest:{size:"Medium",color:"Yellow",key_slot:"BLARG"}
    assert_not_nil assigns(:chest), "Chest is not getting assigned as an instance variable in the controller"
    assert_equal "BLARG", assigns(:chest)[:key_slot], "key_slot was not mass assigned"
  end

  test "mass assignment with Shields Up parameters is safe" do
    user = FactoryGirl.create(:user)
    sign_in user

    get :index
    assert_equal "#{user.id}_reference_letters", Letter.table_name, "Table name is not correct"

    post :safe_wsu, chest:{size:"Large",color:"Orange",key_slot:"blarg"}
    assert_not_nil assigns(:chest), "Chest is not getting assigned as an instance variable in the controller"
    assert_nil assigns(:chest)[:key_slot]
  end
end
