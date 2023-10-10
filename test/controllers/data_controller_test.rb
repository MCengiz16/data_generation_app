require "test_helper"

class DataControllerTest < ActionDispatch::IntegrationTest
  test "should get input" do
    get data_input_url
    assert_response :success
  end

  test "should get generate" do
    get data_generate_url
    assert_response :success
  end
end
