require "test_helper"

class DataverseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dataverse_index_url
    assert_response :success
  end

  test "should get show" do
    get dataverse_show_url
    assert_response :success
  end
end
