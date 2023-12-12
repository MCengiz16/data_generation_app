require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get guardian" do
    get pages_guardian_url
    assert_response :success
  end
end
