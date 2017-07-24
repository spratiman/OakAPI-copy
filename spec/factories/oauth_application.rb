FactoryGirl.define do
  factory :oauth_application, :class => Doorkeeper::Application, aliases: [:application]  do
    name          { Faker::App.name }
    uid           { Faker::Internet.password(20, 20) }
    secret        { Faker::Internet.password(20, 20) }
    redirect_uri  'http://localhost:3000'
    scopes        ''
  end
end