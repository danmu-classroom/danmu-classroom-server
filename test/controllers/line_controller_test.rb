require 'test_helper'

class LineControllerTest < ActionDispatch::IntegrationTest
  test "should get callback" do
    get line_callback_url
    assert_response :success
  end

end
