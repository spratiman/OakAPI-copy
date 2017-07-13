require 'test_helper'

class RatingsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @rating = ratings(:one)
    @term = terms(:fall)
    @user = users(:richard)
    @user_two = users(:erlich)
    @headers = {'Accept' => 'application/vnd.oak.v1'}
  end

  teardown do
    @rating = nil
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to get all the ratings for a term in a course
  # with and without authentication
  # ----------------------------------------------------------------------

  test "should get index without auth" do
    get term_ratings_url(@term), headers: @headers
    assert_response :success
  end

  test "should get index with auth" do
    sign_in @user
    get term_ratings_url(@term), headers: @headers
    assert_response :success
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to view single ratings for a term in a course
  # with and without authentication
  # ----------------------------------------------------------------------

  test "should get show without auth" do
    get rating_url(@rating), headers: @headers
    assert_response :success
  end

  test "should get show" do
    sign_in @user
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
    sign_in @user
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
    sign_in @user
    get rating_url(@rating), headers: @headers
    expected = user_url(@user, format: :json)
    actual = json_response[:data][:user_url]
    assert_equal expected, actual
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to add rating for terms in a course without
  # authentication and with
  #
  # After, adding the rating, make sure it is assigned to the proper
  # term and user
  # ----------------------------------------------------------------------
  test "should not add rating without auth" do
    post term_ratings_url(@term), headers: @headers, params: {'value': 1, 'rating_type': 'overall'}
    assert_response 401
  end

  test "should add rating with auth" do
    sign_in @user_two
    post term_ratings_url(@term), headers: @headers, params: {'value': 1, 'rating_type': 'overall'}
    assert_equal 1, json_response[:value]
    assert_equal @user_two.id, json_response[:user_id]
    assert_equal @term.id, json_response[:term_id]
    assert_response :success
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to modify ratings for courses and make
  # sure they are only done by the same user who created it
  #
  # Make sure we can remove the rating entirely
  # ----------------------------------------------------------------------
  test "ability to modify rating with different user" do
    sign_in @user_two
    put rating_url(@rating), headers: @headers, params: {'value': 0}
    assert_response 401
  end

  test "ability to modify rating with the creator" do
    sign_in @user
    put rating_url(@rating), headers: @headers, params: {'value': 0}
    assert_response :success

    assert_equal 0, json_response[:value]
  end

  test "ability to modify rating to not 0 or 1 with the creator" do
    sign_in @user
    put rating_url(@rating), headers: @headers, params: {'value': 3}
    assert_response 400
  end
end
