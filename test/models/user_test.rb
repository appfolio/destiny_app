require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_after_remote_authentication
    user = User.new

    remote_user = stub(:first_name => 'Donnie', :last_name => 'San', :user_roles => '')
    user.after_remote_authentication(remote_user)

    assert_equal 'Donnie San', user.name
  end
end
