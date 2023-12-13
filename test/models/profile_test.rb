# frozen_string_literal: true

require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  test 'belongs_to user' do
    assert_nothing_raised do
      profiles(:one).user
    end
  end
end
