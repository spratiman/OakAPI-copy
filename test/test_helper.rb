ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
end

module RequestHelper
  # Helper method that parses JSON strings into Hashes
  def json_response
    @json_response ||= JSON.parse(@response.body, symbolize_names: true)
  end
end

module AuthHelper
  # Helper method that authenticates the given user
  def add_auth_headers(headers, user)
    auth_headers = user.create_new_auth_token
    headers.merge!(auth_headers.slice("access-token", "client", "uid"))
  end
end

class ActionDispatch::IntegrationTest
  include RequestHelper
  include AuthHelper
end