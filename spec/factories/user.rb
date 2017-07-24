FactoryGirl.define do
  factory :user, 
          class: Api::V1::User, 
          aliases: [:commenter, :rater, :student, :resource_owner] do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name

    name                   { first_name + ' ' + last_name }
    nickname               { first_name }
    email                  { Faker::Internet.email("#{first_name}.#{last_name}".downcase) }
    password               'valid_password'
    password_confirmation  'valid_password'
  end
end
