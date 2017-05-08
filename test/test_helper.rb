ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
end

class ActionDispatch::IntegrationTest
  # Add a helper method that parses JSON strings into something we can use
  def json_response
    @json_response ||= JSON.parse(@response.body, symbolize_names: true)
  end
end