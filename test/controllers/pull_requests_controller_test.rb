# frozen_string_literal: true

require 'test_helper'

class PullRequestsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get pull_requests_index_url
    assert_response :success
  end

  test 'should get show' do
    get pull_requests_show_url
    assert_response :success
  end
end
