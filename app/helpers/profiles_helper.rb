# frozen_string_literal: true

module ProfilesHelper
  include ThemesHelper

  def profile_owner?(profile)
    user_signed_in? && current_user == profile.user
  end

  # =============================
  # Divs and spans
  # =============================
  def tag_spacer
    tag.span class: 'w-1'
  end

  def tag_show_profile_buttons(profile)
    tag.div class: 'mt-2 w-full flex flex-row justify-center w-full' do
      concat index_profiles_button
      concat tag_spacer
      concat edit_profile_button(profile)
      concat tag_spacer
      concat delete_profile_button(profile)
    end
  end

  # =============================
  # Buttons and Links
  # =============================
  def show_profile_button(profile)
    link_to 'Show profile', profile, class: button_css(:gray)
  end

  def new_profile_button
    link_to 'New profile', new_profile_path, class: button_css(:blue)
  end

  def edit_profile_button(profile)
    return unless profile_owner?(profile)

    link_to 'Edit profile', edit_profile_path(profile), class: button_css(:gray)
  end

  def delete_profile_button(profile)
    return unless profile_owner?(profile)

    button_to 'Delete profile', profile_path(profile), method: :delete, class: button_css(:red)
  end

  def index_profiles_button
    link_to 'Back to profiles', profiles_path, class: button_css(:gray)
  end
end
