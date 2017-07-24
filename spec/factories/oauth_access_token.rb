FactoryGirl.define do
  factory :oauth_token, :class => Doorkeeper::AccessToken do
    application
    resource_owner
  end
end