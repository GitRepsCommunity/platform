# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # rubocop:disable Metrics/BlockLength

  test 'from_omniauth' do
    auth_response = {
      'provider' => 'github',
      'uid' => '59379906',
      'info' => {
        'nickname' => 'andrewjumanca',
        'email' => 'andrewjumanca@gmail.com',
        'image' => 'https://avatars.githubusercontent.com/u/59379906?v=4'
      },
      'credentials' => {
        'token' => '{\"p\":\"PO/SR+xSiR7NsxNdhwfiG8N8HqAAlXdqCQsJvdOfulxuSypzVAG+YQ==\",' \
                   '\"h\":{\"iv\":\"VwxVWLF/5FO3Xt1K\",\"at\":\"WahZ6O4/aSdbTZXcgXmjnQ==\"}}'
      },
      'extra' => {
        'raw_info' => {
          'login' => 'andrewjumanca',
          'avatar_url' => 'https://avatars.githubusercontent.com/u/59379906?v=4',
          'url' => 'https://api.github.com/users/andrewjumanca',
          'html_url' => 'https://github.com/andrewjumanca'
        },
        'all_emails' => [
          { 'email' => '59379906+andrewjumanca@users.noreply.github.com' },
          { 'email' => 'jumanca@uw.edu' },
          { 'email' => 'andrewjumanca@gmail.com' }
        ]
      }
    }

    user = User.from_omniauth(auth_response)

    assert user.valid?
    assert_equal auth_response['provider'], user.provider
    assert_equal auth_response['uid'], user.uid
    assert_equal auth_response['info']['nickname'], user.github_username
    assert_not_nil user.password
    assert_equal 20, user.password.length
    assert_equal auth_response['info']['email'], user.email
    assert_equal auth_response['info']['image'], user.profile_pic_url
    assert_equal auth_response['credentials']['token'], user.github_token
  end
end
# rubocop:enable Metrics/BlockLength
