require 'test_helper'

class ContactListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get contact_lists_index_url
    assert_response :success
  end

end
