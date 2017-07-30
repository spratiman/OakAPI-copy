FactoryGirl.define do
  factory :course, :class => Course do
    code        { 3.times.map{('a'..'z').to_a[rand(26)]}.join + 3.times.map{rand(10)}.join }
    title       { Faker::Educator.unique.course }
    department  { Faker::Job.field }
    division    { Faker::Educator.university }
    level       { [100, 200, 300, 400].sample }
    campus      { ['UTSG', 'UTM', 'UTSC'].sample }
  end
end
