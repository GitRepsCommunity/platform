# frozen_string_literal: true

require 'application_system_test_case'

class UserRegistrationsTest < ApplicationSystemTestCase
  test 'user registration with GitHub' do
    visit '/users/sign_up'
    click_on 'Sign up with GitHub'
    assert(page.current_url.start_with?('https://github.com/login'), "Current URL is not as expected: #{current_url}")
  end
end
