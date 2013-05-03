require 'test_helper'

class ApiControllerTest < ActionController::TestCase
	test "should get files" do 
		get :files
		assert_response :success
	end

	test "should get ephem" do 
		get :ephem
		assert_response :success
	end

	test "should get events" do 
		get :events
		assert_response :success
	end


end
