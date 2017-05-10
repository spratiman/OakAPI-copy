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

  '''
  Testing for the ability to view all the comments for a course with and without
  authentication
  '''
  test "should get index without auth" do
    get course_comments_url(@course), headers: {'Accept' => 'application/vnd.oak.v1'}, as: :json
    assert_response :success
  end

  test "should get index" do
    get course_comments_url(@course), headers: @auth_headers, as: :json
    assert_response :success
  end

  '''
  Testing for the ability to view a single comment for a course with and without
  authentication
  '''
  test "should get show without auth" do
    get course_comment_url(@course, @comment), headers: {'Accept' => 'application/vnd.oak.v1'}, as: :json
    assert_response :success
  end

  test "should get show" do
    get course_comment_url(@course, @comment), headers: @auth_headers, as: :json
    assert_response :success
  end

  '''
  Testing for the ability to view a single comment and making sure its the correct one
  with and without authentication
  '''
  test "show should display comment without auth" do
    get course_comment_url(@course, @comment), headers: {'Accept' => 'application/vnd.oak.v1'}, as: :json
    expected = @comment.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

  test "show should display comment" do
    get course_comment_url(@course, @comment), headers: @auth_headers, as: :json
    expected = @comment.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

  '''
  Testing for the ability to view a single comment and making sure the user corresponds to it
  correctly with and without authentication
  '''
  test "show should dispaly user url without auth" do
    get course_comment_url(@course, @comment), headers: {'Accept' => 'application/vnd.oak.v1'}, as: :json
    expected = user_url(@user)
    actual = json_response[:data][:user_url]
    assert_equal expected, actual
  end

  test "show should display user url" do
    get course_comment_url(@course, @comment), headers: @auth_headers, as: :json
    expected = user_url(@user)
    actual = json_response[:data][:user_url]
    assert_equal expected, actual
  end
  
end
