require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  test "should_not_allow_multiple_ratings" do
    rating = Rating.new(user: users(:richard), course: courses(:csc373),
                        rating_type: "overall", value: true)
    assert_raises(ActiveRecord::RecordNotUnique) do
      rating.save
    end
  end

  test "should_not_allow_ratings_without_rating" do
    rating = Rating.new(course: courses(:csc373), user: users(:richard))
    assert_not rating.save
  end

  test "should_not_allow_ratings_without_user" do
    rating = Rating.new(course: courses(:csc373))
    assert_not rating.save
  end

  test "should_not_allow_ratings_without_course" do
    rating = Rating.new(user: users(:richard))
    assert_not rating.save
  end

  test "should_not_allow_rating_without_proper_type" do
    rating = Rating.new(course: courses(:csc373), user: users(:erlich), value: true, rating_type: 'False')
    assert_not rating.save
  end

  test "should_update_body" do
    rating = ratings(:one)
    rating.value = false
    assert rating.save
  end
end
