require 'test_helper'

class Api::V1::CommentsControllerTest < ActionDispatch::IntegrationTest
  
  setup do
  	@comment = comments(:one)
  	@course = courses(:csc373)
    @user = users(:richard)
    @user.save!
    @auth_headers = @user.create_new_auth_token
    @auth_headers.merge!({'Accept' => 'application/vnd.oak.v1'})
  end

  teardown do
    @course = nil
  end

  test "should get index" do
  	get course_comments_url(@course), headers: @auth_headers, as: :json
  	assert_response :success
  end

  test "should get show" do
    get course_comment_url(@course, @comment), headers: @auth_headers, as: :json
    assert_response :success
  end

  test "show should display comment" do
  	get course_comment_url(@course, @comment), headers: @auth_headers, as: :json
    expected = @comment.id
    actual = json_response[:data][:id]
  	assert_equal expected, actual
  end

  test "should should display user url" do
    get course_comment_url(@course, @comment), headers: @auth_headers, as: :json
    expected = user_url(@user)
    actual = json_response[:data][:user_url]
    assert_equal expected, actual
  end
  
end
