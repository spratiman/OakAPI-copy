require 'test_helper'

class Api::V1::CoursesControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @course = courses(:csc373)
    @user = users(:richard)
    @headers = {'Accept' => 'application/vnd.oak.v1'}
  end

  teardown do
    @course = nil
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to get all the courses with and without 
  # authentication
  # ----------------------------------------------------------------------

  test "should get index without auth" do
    get courses_url, headers: @headers
    assert_response :success
  end

  test "should get index with auth" do
    add_auth_headers(@headers, @user)
    get courses_url, headers: @headers
    assert_response :success
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to look at a single course with and without 
  # user authentication
  # ----------------------------------------------------------------------

  test "should get show without auth" do
    get course_url(@course), headers: @headers
    assert_response :success
  end

  test "should get show with auth" do
    add_auth_headers(@headers, @user)
    get course_url(@course), headers: @headers
    assert_response :success
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to look at a single course and make sure its 
  # the correct one with and without authentication
  # ----------------------------------------------------------------------

  test "show should show course without auth" do
    get course_url(@course), headers: @headers
    assert_response :success
  end

  test "show should show course with auth" do
    add_auth_headers(@headers, @user)
    get course_url(@course), headers: @headers
    expected = @course.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end
  
end
