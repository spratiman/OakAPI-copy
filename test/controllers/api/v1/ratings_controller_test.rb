require 'test_helper'

class RatingsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @rating = ratings(:one)
    @course = courses(:csc373)
    @user = users(:richard)
    @user_two = users(:erlich)
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
    get course_rating_url(@course, @rating), headers: @headers
    assert_response :success
  end

  test "should get show" do
    add_auth_headers(@headers, @user)
    get course_rating_url(@course, @rating), headers: @headers
    assert_response :success
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to view single ratings and making sure the
  # its the correct one (IDs match) with and without authentication
  # ----------------------------------------------------------------------

  test "show should display rating without auth" do
    get course_rating_url(@course, @rating), headers: @headers
    expected = @rating.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

  test "show should display rating" do
    add_auth_headers(@headers, @user)
    get course_rating_url(@course, @rating), headers: @headers
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
    get course_rating_url(@course, @rating), headers: @headers
    expected = user_url(@user, format: :json)
    actual = json_response[:data][:user_url]
    assert_equal expected, actual
  end

  test "should should display user url" do
    add_auth_headers(@headers, @user)
    get course_rating_url(@course, @rating), headers: @headers
    expected = user_url(@user, format: :json)
    actual = json_response[:data][:user_url]
    assert_equal expected, actual
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to add rating for courses without
  # authentication and with
  #
  # After, adding the rating, make sure it is assigned to the proper
  # course and user
  # ----------------------------------------------------------------------
  test "should not add rating without auth" do
    post course_ratings_url(@course), headers: @headers, params: {'value': true, 'rating_type': 'Overall'}
    assert_response 401
  end

  test "should add rating with auth" do
    add_auth_headers(@headers, @user_two)
    post course_ratings_url(@course), headers: @headers, params: {'value': true, 'rating_type': 'Overall'}
    assert_equal true, json_response[:value]
    assert_equal @user_two.id, json_response[:user_id]
    assert_equal @course.id, json_response[:course_id]
    assert_response :success
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to modify ratings for courses and make
  # sure they are only done by the same user who created it
  #
  # Make sure we can remove the rating entirely
  # ----------------------------------------------------------------------
  test "ability to modify rating with different user" do
    add_auth_headers(@headers, @user_two)
    put course_rating_url(@course, @rating), headers: @headers, params: {'value': false}
    assert_response 401
  end

  test "ability to modify rating with the creator" do
    add_auth_headers(@headers, @user)
    put course_rating_url(@course, @rating), headers: @headers, params: {'value': false}
    assert_response :success

    assert_equal false, json_response[:value]
  end

  test "ability to modify rating to nothing with the creator" do
    add_auth_headers(@headers, @user)
    put course_rating_url(@course, @rating), headers: @headers, params: {'value': nil}
    assert_response 400
  end
end
