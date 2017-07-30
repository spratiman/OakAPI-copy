FactoryGirl.define do
  factory :comment, :class => Comment do
    body { Faker::Movie.quote }
    user
    course
  end
end
