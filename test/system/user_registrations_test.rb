# frozen_string_literal: true

require 'application_system_test_case'

class UserRegistrationsTest < ApplicationSystemTestCase
  visit new_user_registration_url
  click_on 'Sign up with GitHub'
  assert_redirected_to %r{\Ahttps://github.com/login}
end
