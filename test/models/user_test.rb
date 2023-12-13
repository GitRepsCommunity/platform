# frozen_string_literal: true

require 'test_helper'
require 'json'

class UserTest < ActiveSupport::TestCase
  test 'has_many profiles' do
    user = User.find(1)
    assert_equal 1, user.profiles.count

    user.profiles.create
    assert_equal 2, user.profiles.count

    # dependent: :destroy
    profile_ids = user.profiles.ids
    user.destroy
    assert_equal 0, Profile.where(id: profile_ids).count
  end

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

    assert_equal raw_auth_response['info']['email'], auth.email
    assert_equal auth.email, user.email

    assert_equal raw_auth_response['info']['image'], auth.profile_pic_url
    assert_equal auth.profile_pic_url, user.profile_pic_url

    assert_equal raw_auth_response['credentials']['token'], auth.github_token
    assert_equal auth.github_token, user.github_token
  end
end
