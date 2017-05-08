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
  
  test "should get index" do
    get course_ratings_url(@course), headers: @auth_headers, as: :json
    assert_response :success
  end

  test "should get show" do
    get course_rating_url(@course, @rating), headers: @auth_headers, as: :json
    assert_response :success
  end

  test "show should display rating" do
    get course_rating_url(@course, @rating), headers: @auth_headers, as: :json
    expected = @rating.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

  test "should should display user url" do
    get course_rating_url(@course, @rating), headers: @auth_headers, as: :json
    expected = user_url(@user, format: :json)
    actual = json_response[:data][:user_url]
    assert_equal expected, actual
  end
  
end
