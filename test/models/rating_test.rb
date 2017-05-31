require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  test "should not allow multiple ratings" do
    rating = Rating.new(user: users(:richard), course: courses(:csc373),
                        rating_type: "overall", value: 1)
    assert_raises(ActiveRecord::RecordNotUnique) do
      rating.save
    end
  end

  test "should not allow ratings without user" do
    rating = Rating.new(course: courses(:csc373), user: users(:richard))
    assert_not rating.save
  end

  test "should not allow ratings without course" do
    rating = Rating.new(user: users(:richard))
    assert_not rating.save
  end

  test "should not allow rating without proper type" do
    rating = Rating.new(course: courses(:csc373), user: users(:erlich), value: 1, rating_type: 'False')
    assert_not rating.save
  end

  test "should update body" do
    rating = ratings(:one)
    rating.value = 0
    assert rating.save
  end
end
