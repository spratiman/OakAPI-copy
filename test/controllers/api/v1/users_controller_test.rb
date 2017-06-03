require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:richard)
    @user_two = users(:erlich)
    @headers = {'Accept' => 'application/vnd.oak.v1'}
  end

  teardown do
    @user = nil
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to get all the users and also check single
  # users with its corresponding ids with and without authentication
  # ----------------------------------------------------------------------

  test "should not get index without auth" do
    get users_url, headers: @headers
    assert_response :unauthorized
  end

  test "should get index with auth" do
    add_auth_headers(@headers, @user)
    get users_url, headers: @headers
    assert_response :success
  end

  test "should not show user without auth" do
    get user_url(@user), headers: @headers
    assert_response :unauthorized
  end

  test "should show user with auth" do
    add_auth_headers(@headers, @user)
    get user_url(@user), headers: @headers
    assert_response :success
  end

  test "should not show user information without auth" do
    get user_url(@user), headers: @headers
    assert_response :unauthorized
  end

  test "should display user information with auth" do
    add_auth_headers(@headers, @user)
    get user_url(@user), headers: @headers
    expected = @user.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to create accounts if provided all the
  # information and make sure it complies with our requirements
  #
  # Only possible with no authentication. Authenticated requests should
  # not be able make new accounts)
  # ----------------------------------------------------------------------

  test "should not create user when authenticated" do
    add_auth_headers(@headers, @user)
    post user_registration_url, headers: @headers, params: {'name': 'Gavin Belson', 'nickname': 'Gavin',
      'email': 'gavin@piedpiper.io', 'password': 'hoolibad', 'password_confirmation': 'hoolibad'}
    assert_response :unauthorized
  end

  test "should create user when not authenticated" do
    post user_registration_url, headers: @headers, params: {'name': 'Gavin Belson', 'nickname': 'Gavin',
      'email': 'gavin@piedpiper.io', 'password': 'hoolibad', 'password_confirmation': 'hoolibad'}
    assert_response :success
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to create multiple accounts which should
  # not be allowed
  # ----------------------------------------------------------------------

  test "should not create another same user" do
    post user_registration_url, headers: @headers, params: {'name': 'Gavin Belson', 'nickname': 'Gavin',
      'email': 'gavin@piedpiper.io', 'password': 'hoolibad', 'password_confirmation': 'hoolibad'}
    assert_response :success

    post user_registration_url, headers: @headers, params: {'name': 'Blood Boy', 'nickname': 'Druggie',
      'email': 'gavin@piedpiper.io', 'password': 'bloody', 'password_confirmation': 'bloody'}
    assert_response :unprocessable_entity
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to update the user information with only the
  # correct account. Make sure the information is correctly changed after.
  # ----------------------------------------------------------------------
  test "should not let us update user without auth" do
    post user_registration_url, headers: @headers, params: {'name': 'Blood Boy', 'nickname': 'Druggie',
      'email': 'gavin@piedpiper.io', 'password': 'bloody', 'password_confirmation': 'bloody'}

    gavin_user = User.find_by_email('gavin@piedpiper.io')
    put user_registration_url(gavin_user), headers: @headers, params: {'nickname': 'Russ', 'current_password': 'bloody'}
    assert_response :not_found
  end

  test "should let us update user" do
    post user_registration_url, headers: @headers, params: {'name': 'Blood Boy', 'nickname': 'Druggie',
      'email': 'gavin@piedpiper.io', 'password': 'bloody', 'password_confirmation': 'bloody'}

    gavin_user = User.find_by_email('gavin@piedpiper.io')
    add_auth_headers(@headers, gavin_user)
    put user_registration_url(gavin_user), headers: @headers, params: {'nickname': 'Russ', 'current_password': 'bloody'}
    assert_response :success

    get user_url(gavin_user), headers: @headers
    expected = 'Russ'
    actual = json_response[:data][:nickname]
    assert_equal expected, actual
  end
end
