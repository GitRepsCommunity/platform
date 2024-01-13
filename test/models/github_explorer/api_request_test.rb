# frozen_string_literal: true

require 'test_helper'
require 'minitest/mock'

module GithubExplorer
  class ApiRequestTest < ActiveSupport::TestCase
    test 'belongs_to user' do
      api_request = users(:one).api_requests.create

      assert_nothing_raised do
        api_request.user
      end
    end

    test 'send_request_and_save! handles json arrays' do
      api_request = users(:one).api_requests.create

      test_response = JSON.parse('[]')
      api_request.stub :send_request, test_response do
        api_request.send_request_and_save!
        assert_equal test_response, api_request.response
        assert api_request.response.is_a?(Array)
      end
    end

    test 'send_request_and_save! handles json objects' do
      api_request = users(:one).api_requests.create

      test_response = JSON.parse('{}')
      api_request.stub :send_request, test_response do
        api_request.send_request_and_save!
        assert_equal test_response, api_request.response
        assert api_request.response.is_a?(Hash)
      end
    end
  end
end
