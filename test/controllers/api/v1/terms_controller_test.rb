require 'test_helper'

class Api::V1::TermsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @course = courses(:csc373)
    @user = users(:richard)
    @term = terms(:one)
    @headers = {'Accept' => 'application/vnd.oak.v1'}
  end

  teardown do
    @course = nil
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to get all the terms for a course with and
  # without authentication
  # ----------------------------------------------------------------------

  test "should get index without auth" do
    get course_terms_url(@course), headers: @headers
    assert_response :success
  end

  test "should get index with auth" do
    add_auth_headers(@headers, @user)
    get course_terms_url(@course), headers: @headers
    assert_response :success
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to look at a single term for a course with
  # and without user authentication
  # ----------------------------------------------------------------------

  test "should get show without auth" do
    get term_url(@term), headers: @headers
    assert_response :success
  end

  test "should get show with auth" do
    add_auth_headers(@headers, @user)
    get term_url(@term), headers: @headers
    assert_response :success
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to look at a single term for a course and
  # make sure its the correct one with and without authentication
  # ----------------------------------------------------------------------

  test "show should show term without auth" do
    get term_url(@term), headers: @headers
    expected = @term.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

  test "show should show term with auth" do
    add_auth_headers(@headers, @user)
    get term_url(@term), headers: @headers
    expected = @term.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

end
