ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!
require 'mocha/mini_test'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Helper method that parses JSON strings into Hashes
  def json_response
    @json_response ||= JSON.parse(@response.body, symbolize_names: true)
  end

  # Helper method that signs in user (stub)
  def sign_in user
    token = Doorkeeper::AccessToken.create!(resource_owner_id: user.id, scopes: 'public')
    ApplicationController.any_instance.stubs(:doorkeeper_token).returns(token)
  end
end
