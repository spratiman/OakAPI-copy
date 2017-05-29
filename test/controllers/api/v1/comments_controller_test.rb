require 'test_helper'

class Api::V1::CommentsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @comment = comments(:one)
    @comment_with_reply = comments(:two)
    @reply = comments(:three)
    @course = courses(:csc373)
    @user = users(:richard)
    @user2 = users(:dinesh)
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
    get comment_url(@comment), headers: @headers
    assert_response :success
  end

  test "should get show with auth" do
    add_auth_headers(@headers, @user)
    get comment_url(@comment), headers: @headers
    assert_response :success
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to view a single comment and making sure its 
  # the correct one with and without authentication
  # ----------------------------------------------------------------------

  test "show should display comment without auth" do
    get comment_url(@comment), headers: @headers
    expected = @comment.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

  test "show should display comment with auth" do
    add_auth_headers(@headers, @user)
    get comment_url(@comment), headers: @headers
    expected = @comment.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to view a single comment and making sure the 
  # user corresponds to it correctly with and without authentication
  # ----------------------------------------------------------------------

  test "show should display user url without auth" do
    get comment_url(@comment), headers: @headers
    expected = user_url(@user)
    actual = json_response[:data][:user_url]
    assert_equal expected, actual
  end

  test "show should display user url with auth" do
    add_auth_headers(@headers, @user)
    get comment_url(@comment), headers: @headers
    expected = user_url(@user)
    actual = json_response[:data][:user_url]
    assert_equal expected, actual
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to view a single comment and making sure that
  # the immediate replies to that comment are shown with and without 
  # authentication
  # ----------------------------------------------------------------------
  
  test "show should display replies for comment with reply without auth" do
    get comment_url(@comment_with_reply), headers: @headers
    expected = @comment_with_reply.children[0][:id]
    actual = json_response[:data][:replies][0][:id]
    assert_equal expected, actual
  end

  test "show should display replies for comment with reply with auth" do
    add_auth_headers(@headers, @user)
    get comment_url(@comment_with_reply), headers: @headers
    expected = @comment_with_reply.children[0][:id]
    actual = json_response[:data][:replies][0][:id]
    assert_equal expected, actual
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to delete a single comment with and without 
  # authentication
  # ----------------------------------------------------------------------

  test "destroy should fail when not authenticated" do
    delete comment_url(@comment), headers: @headers
    assert_response :unauthorized
  end

  test "destroy should fail when authenticated user not author" do
    other_user = users(:dinesh)
    add_auth_headers(@headers, other_user)
    delete comment_url(@comment), headers: @headers
    assert_response :unauthorized
  end

  test "destroy should fail when comment has replies" do
    author = users(:dinesh)
    add_auth_headers(@headers, author)
    delete comment_url(@comment_with_reply), headers: @headers
    assert_response :unprocessable_entity
  end

  test "destroy should delete comment when it has no replies" do
    add_auth_headers(@headers, @user)
    delete comment_url(@comment), headers: @headers
    assert_response :no_content
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to update a single comment with and without
  # authentication
  # ----------------------------------------------------------------------

  test "update should fail when user not authenticated" do
    patch comment_url(@comment), params: {body: "This comment is updated."}, headers: @headers
    assert_response :unauthorized
  end

  test "update should fail when authenticated user not author" do
    other_user = users(:dinesh)
    add_auth_headers(@headers, other_user)
    patch comment_url(@comment), params: {body: "This comment is updated."}, headers: @headers
    assert_response :unauthorized
  end

  test "update should update body when authenticated user is author" do
    add_auth_headers(@headers, @user)
    patch comment_url(@comment), params: {body: "This comment is updated."}, headers: @headers
    assert_response :ok
  end

  test "update should fail comment has replies" do
    add_auth_headers(@headers, @user2)
    patch comment_url(@comment_with_reply), params: {body: "This comment is updated."}, headers: @headers
    assert_response :unprocessable_entity
  end
end
