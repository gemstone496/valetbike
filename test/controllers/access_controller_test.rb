require "test_helper"

class AccessControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get access_create_url
    assert_response :success
  end
end
