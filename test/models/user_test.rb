# frozen_string_literal: true

require 'test_helper'
require 'json'

class UserTest < ActiveSupport::TestCase
  test 'from_omniauth' do
    raw_auth_response = JSON.parse(File.read('test/fixtures/omniauth_response.json'))

    auth = OmniauthResponse.new(response: raw_auth_response)
    user = User.from_omniauth(auth)

    assert user.valid?

    assert_equal raw_auth_response['provider'], auth.provider
    assert_equal auth.provider, user.provider

    assert_equal raw_auth_response['uid'], auth.uid
    assert_equal auth.uid, user.uid

    assert_equal raw_auth_response['info']['nickname'], auth.github_username
    assert_equal auth.github_username, user.github_username

    assert_not_nil user.password
    assert_equal 20, user.password.length

    assert_equal raw_auth_response['info']['email'], auth.email
    assert_equal auth.email, user.email

    assert_equal raw_auth_response['info']['image'], auth.profile_pic_url
    assert_equal auth.profile_pic_url, user.profile_pic_url

    assert_equal raw_auth_response['credentials']['token'], auth.github_token
    assert_equal auth.github_token, user.github_token
  end
end
