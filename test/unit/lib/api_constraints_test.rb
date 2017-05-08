require 'test_helper'
require 'api_constraints'
require 'minitest/mock'

class ApiConstraintsTest < ActiveSupport::TestCase
	setup do
		@api_constraints_v1 = ApiConstraints.new(version: 1)
		class Request
			def headers
				{}
			end 
		end
		@request = Request.new
	end

	test "matches? should return false when there no version in Accept header" do
		@request.stub :headers, {'Accept' => ''} do
			assert_not @api_constraints_v1.matches?(@request)
		end
	end

	test "matches? should return true when version matches Accept header" do
		@request.stub :headers, {'Accept' => 'application/vnd.oak.v1'} do
    	assert @api_constraints_v1.matches?(@request)
    end
	end

end  