# frozen_string_literal: true

require 'test_helper'

module GithubExplorer
  class ApiRequestTest < ActiveSupport::TestCase
    test 'belongs_to user' do
      api_request = users(:one).api_requests.create

      assert_nothing_raised do
        api_request.user
      end
    end
  end
end
