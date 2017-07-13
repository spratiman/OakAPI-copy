require 'test_helper'

class Api::V1::TermsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @course = courses(:csc373)
    @user = users(:richard)
    @term = terms(:fall)
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
    sign_in @user
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
    sign_in @user
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
    sign_in @user
    get term_url(@term), headers: @headers
    expected = @term.id
    actual = json_response[:data][:id]
    assert_equal expected, actual
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to enrol in a term that relates to a course
  # and make sure it shows up in the user enrolments and does not work
  # without authentication.
  #
  # Test to make sure a user can only enrol in a term once
  # ----------------------------------------------------------------------

  test "enrol should not work without auth" do
    post enrol_term_url(@term), headers: @headers
    assert_response :unauthorized
  end

  test "enrol should work with auth" do
    sign_in @user
    post enrol_term_url(@term), headers: @headers

    assert_equal @term.id, @user.enrolments.as_json[0]['term_id']
    assert_equal @user.id, @user.enrolments.as_json[0]['user_id']
  end

  test "enrol should work with auth only once" do
    sign_in @user
    post enrol_term_url(@term), headers: @headers
    assert_response :success

    post enrol_term_url(@term), headers: @headers
    assert_response :bad_request
  end

  # ----------------------------------------------------------------------
  # Testing for the ability to enrol in a term that relates to a course
  # and make sure it shows up in the user enrolments and does not work
  # without authentication
  # ----------------------------------------------------------------------

  test "de-enrol should not work without auth" do
    delete remove_enrol_term_url(@term), headers: @headers
    assert_response :unauthorized
  end

  test "de-enrol should work with auth" do
    sign_in @user
    post enrol_term_url(@term), headers: @headers
    delete remove_enrol_term_url(@term), headers: @headers

    assert_response :success
    assert @user.enrolments.empty?
  end
end
