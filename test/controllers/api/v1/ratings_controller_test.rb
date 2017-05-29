require 'test_helper'

class RatingsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @rating = ratings(:one)
    @course = courses(:csc373)
    @user = users(:richard)
    @headers = {'Accept' => 'application/vnd.oak.v1'}
  end

  teardown do
    @rating = nil
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to get all the ratings for a course with and 
  # without authentication
  # ----------------------------------------------------------------------

  test "should get index without auth" do
    get course_ratings_url(@course), headers: @headers
    assert_response :success
  end

  test "should get index with auth" do
    add_auth_headers(@headers, @user)
    get course_ratings_url(@course), headers: @headers
    assert_response :success
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to view single ratings for courses with and 
  # without authentication
  # ----------------------------------------------------------------------

  test "should get show without auth" do
    get rating_url(@rating), headers: @headers
    assert_response :success
  end

  test "should get show" do
    add_auth_headers(@headers, @user)
    get rating_url(@rating), headers: @headers
    assert_response :success
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to view single ratings and making sure the
  # its the correct one (IDs match) with and without authentication
  # ----------------------------------------------------------------------

  test "show should display rating without auth" do
    get rating_url(@rating), headers: @headers
    expected = @rating.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

  test "show should display rating" do
    add_auth_headers(@headers, @user)
    get rating_url(@rating), headers: @headers
    expected = @rating.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to making sure the user url for the rating is 
  # correct and corresponds to the correct user with and without 
  # authentication
  # ----------------------------------------------------------------------

  test "should should display user url without auth" do
    get rating_url(@rating), headers: @headers
    expected = user_url(@user, format: :json)
    actual = json_response[:data][:user_url]
    assert_equal expected, actual
  end

  test "should should display user url" do
    add_auth_headers(@headers, @user)
    get rating_url(@rating), headers: @headers
    expected = user_url(@user, format: :json)
    actual = json_response[:data][:user_url]
    assert_equal expected, actual
  end
  
end
