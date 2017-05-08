require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:richard)
    @user.save!
    @auth_headers = @user.create_new_auth_token
    @auth_headers.merge!({'Accept' => 'application/vnd.oak.v1'})
  end

  teardown do
    @user = nil
  end

  test "should get index" do
    get users_url, headers: @auth_headers, as: :json
    assert_response :success
  end

  test "should show user" do
    get user_url(@user), headers: @auth_headers, as: :json
    assert_response :success
  end

  test "show should display user" do
    get user_url(@user), headers: @auth_headers, as: :json
    expected = @user.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

end
