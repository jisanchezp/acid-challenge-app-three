require 'test_helper'

class Rest::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get rest_sessions_login_url
    assert_response :success
  end

end
