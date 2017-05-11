require 'test_helper'

class RatingsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @rating = ratings(:one)
    @course = courses(:csc373)
    @user = users(:richard)
    @user.save!
    @auth_headers = @user.create_new_auth_token
    @auth_headers.merge!({'Accept' => 'application/vnd.oak.v1'})
  end

  teardown do
    @rating = nil
  end

  '''
  Testing for the ability to get all the ratings for a course with and without
  authentication
  '''
  test "should get index without auth" do
    get course_ratings_url(@course), headers: {'Accept' => 'application/vnd.oak.v1'}, as: :json
    assert_response :success
  end

  test "should get index with auth" do
    get course_ratings_url(@course), headers: @auth_headers, as: :json
    assert_response :success
  end

  '''
  Testing for the ability to view single ratings for courses with and without
  authentication
  '''
  test "should get show without auth" do
    get course_rating_url(@course, @rating), headers: {'Accept' => 'application/vnd.oak.v1'}, as: :json
    assert_response :success
  end

  test "should get show" do
    get course_rating_url(@course, @rating), headers: @auth_headers, as: :json
    assert_response :success
  end

  '''
  Testing for the ability to view single ratings and making sure the
  its the correct one (IDs match) with and without authentication
  '''
  test "show should display rating without auth" do
    get course_rating_url(@course, @rating), headers: {'Accept' => 'application/vnd.oak.v1'}, as: :json
    expected = @rating.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

  test "show should display rating" do
    get course_rating_url(@course, @rating), headers: @auth_headers, as: :json
    expected = @rating.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

  '''
  Testing for the ability to making sure the user url for the rating is correct
  and corresponds to the correct user with and without authentication
  '''
  test "should should display user url without auth" do
    get course_rating_url(@course, @rating), headers: {'Accept' => 'application/vnd.oak.v1'}, as: :json
    expected = user_url(@user, format: :json)
    actual = json_response[:data][:user_url]
    assert_equal expected, actual
  end

  test "should should display user url" do
    get course_rating_url(@course, @rating), headers: @auth_headers, as: :json
    expected = user_url(@user, format: :json)
    actual = json_response[:data][:user_url]
    assert_equal expected, actual
  end

  ''' Testing for the ability to add ratings for courses that are valid

  Make sure its only possible with authentication
  '''

  '''
  Testing for the ability to add ratings for courses and making sure
  it is successful (present in the database). 

  Make sure its only possible with authentication.
  '''

  '''
  Testing for the ability to add ratings for courses and make sure
  they are assigned to proper course.

  Make sure its only possible with authentication.
  '''

  '''
  Testing for the ability to add ratings for courses and make sure
  they are assigned to the correct user.

  Make sure its only possible with authentication
  '''

  '''
  Testing for the ability to modify ratings for courses and make
  sure they are only done by the same user who created it.

  Make sure its only possible with authentication (same user)
  '''

end
