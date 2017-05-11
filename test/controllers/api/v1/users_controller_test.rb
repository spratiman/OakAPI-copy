require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:richard)
    @headers = {'Accept' => 'application/vnd.oak.v1'}
  end

  teardown do
    @user = nil
  end

  test "should get index" do
    add_auth_headers(@headers, @user)
    get users_url, headers: @headers
    assert_response :success
  end

  test "should show user" do
    add_auth_headers(@headers, @user)
    get user_url(@user), headers: @headers
    assert_response :success
  end

  test "show should display user" do
    add_auth_headers(@headers, @user)
    get user_url(@user), headers: @headers
    expected = @user.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

end
