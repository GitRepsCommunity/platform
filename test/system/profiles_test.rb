# frozen_string_literal: true

require 'application_system_test_case'

class ProfilesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @profile = profiles(:one)
    @user = users(:one)
    sign_in @user
  end

  test 'visiting the index' do
    visit profiles_url
    assert_selector 'a', text: 'Profiles'
  end

  test 'should create profile' do
    visit profiles_url
    click_on 'New profile'

    click_on 'Save'

    assert_text 'Profile was successfully created'
    click_on 'Back'
  end

  test 'should update Profile' do
    visit profile_url(@profile)
    click_on 'Edit profile', match: :first

    click_on 'Save'

    assert_text 'Profile was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Profile' do
    visit profile_url(@profile)
    click_on 'Delete profile', match: :first

    assert_text 'Profile was successfully destroyed'
  end
end
