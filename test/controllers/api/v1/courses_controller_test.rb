require 'test_helper'

class Api::V1::CoursesControllerTest < ActionDispatch::IntegrationTest
  
  setup do
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
    get courses_url, headers: @auth_headers, as: :json
    assert_response :success
  end

  test "should get show" do
    get course_url(@course), headers: @auth_headers, as: :json
    assert_response :success
  end

  test "show should show course" do
    get course_url(@course), headers: @auth_headers, as: :json
    expected = @course.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end
  
end
