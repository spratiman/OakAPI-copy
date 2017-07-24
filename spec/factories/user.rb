FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    nickname { Faker::Name.first_name }
    email { Faker::Internet.email(Faker::Name.first_name + "." + Faker::Name.last_name) }
    password { 'valid_password' }
    password_confirmation { 'valid_password' }
  end
end
