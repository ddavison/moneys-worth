require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get front" do
    get pages_front_url
    assert_response :success
  end

end
