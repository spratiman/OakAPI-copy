require 'test_helper'

class Api::V1::CommentsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @comment = comments(:one)
    @course = courses(:csc373)
    @user = users(:richard)
    @user_two = users(:erlich)
    @headers = {'Accept' => 'application/vnd.oak.v1'}
  end

  teardown do
    @course = nil
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to view all the comments for a course with and
  # without authentication
  # ----------------------------------------------------------------------

  test "should get index without auth" do
    get course_comments_url(@course), headers: @headers
    assert_response :success
  end

  test "should get index with auth" do
    add_auth_headers(@headers, @user)
    get course_comments_url(@course), headers: @headers
    assert_response :success
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to view a single comment for a course with and
  # without authentication
  # ----------------------------------------------------------------------

  test "should get show without auth" do
    get course_comment_url(@course, @comment), headers: @headers
    assert_response :success
  end

  test "should get show with auth" do
    add_auth_headers(@headers, @user)
    get course_comment_url(@course, @comment), headers: @headers
    assert_response :success
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to view a single comment and making sure its
  # the correct one with and without authentication
  # ----------------------------------------------------------------------

  test "show should display comment without auth" do
    get course_comment_url(@course, @comment), headers: @headers
    expected = @comment.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

  test "show should display comment with auth" do
    add_auth_headers(@headers, @user)
    get course_comment_url(@course, @comment), headers: @headers
    expected = @comment.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to view a single comment and making sure the
  # user corresponds to it correctly with and without authentication
  # ----------------------------------------------------------------------

  test "show should display user url without auth" do
    get course_comment_url(@course, @comment), headers: @headers
    expected = user_url(@user)
    actual = json_response[:data][:user_url]
    assert_equal expected, actual
  end

  test "show should display user url with auth" do
    add_auth_headers(@headers, @user)
    get course_comment_url(@course, @comment), headers: @headers
    expected = user_url(@user)
    actual = json_response[:data][:user_url]
    assert_equal expected, actual
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to add comments for courses without
  # authentication and with
  #
  # After, adding the comment, make sure it is assigned to the proper
  # course and user
  # ----------------------------------------------------------------------
  test "should not add comment without auth" do
    post course_comments_url(@course), headers: @headers, params: {'body': 'New comment without auth'}
    assert_response 401
  end

  test "should add comment with auth" do
    add_auth_headers(@headers, @user)
    post course_comments_url(@course), headers: @headers, params: {'body': 'New comment with auth'}
    assert_equal 'New comment with auth', json_response[:body]
    assert_equal @user.id, json_response[:user_id]
    assert_equal @course.id, json_response[:course_id]
    assert_response :success
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to modify comments for courses and make
  # sure they are only done by the same user who created it
  #
  # Make sure we can't update the comment after to have a empty body
  # ----------------------------------------------------------------------
  test "ability to modify comment with different user" do
    add_auth_headers(@headers, @user_two)
    put course_comment_url(@course, @comment), headers: @headers, params: {'body': 'Tried to change with wrong user'}
    assert_response 401
  end

  test "ability to modify comment with the creator" do
    add_auth_headers(@headers, @user)
    put course_comment_url(@course, @comment), headers: @headers, params: {'body': 'Tried to change with right user'}
    assert_response :success

    assert_equal 'Tried to change with right user', json_response[:body]
  end

  test "ability to modify comment to empty body with the creator" do
    add_auth_headers(@headers, @user)
    put course_comment_url(@course, @comment), headers: @headers, params: {'body': ''}
    assert_response 400

    assert_equal 'You can not edit this comment to have a empty body', json_response[:errors]
  end
end