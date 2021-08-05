require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get level_up" do
    get users_level_up_url
    assert_response :success
  end

end
