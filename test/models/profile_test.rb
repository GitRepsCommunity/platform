# frozen_string_literal: true

require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  test 'belongs_to user' do
    profile = Profile.find(1)
    assert_equal profile.user_id, profile.user.id
  end
end
