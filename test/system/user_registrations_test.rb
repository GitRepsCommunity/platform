# frozen_string_literal: true

require 'application_system_test_case'

class UserRegistrationsTest < ApplicationSystemTestCase
  test 'Blank inputs' do
    visit new_user_registration_url

    click_on 'Sign up'
    assert page.has_content?("Email can't be blank")
    assert page.has_content?("Password can't be blank")
  end

  test 'Existing account' do
    User.create(email: 'existing@example.com', password: 'password1234')
    visit new_user_registration_url

    fill_in 'Email', with: 'existing@example.com'
    click_on 'Sign up'
    assert page.has_content?('Email has already been taken')
  end

  test 'Invalid password' do
    visit new_user_registration_url

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: '1234'

    click_on 'Sign up'
    assert page.has_content?('Password is too short (minimum is 6 characters)')
  end

  test 'Password confirmation' do
    visit new_user_registration_url

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'Password123'
    fill_in 'Confirm Password', with: 'differentPassword'

    click_on 'Sign up'
    assert page.has_content?("Password confirmation doesn't match Password")
  end

  test 'Successful registration' do
    visit new_user_registration_url

    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'Password123'
    fill_in 'Confirm Password', with: 'Password123'

    click_on 'Sign up'
    assert page.has_content?('')
  end
end
