# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token, only: :github

    def github
      @user = find_or_create_user_from_omniauth
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
      else
        session['devise.github_data'] = request.env['omniauth.auth'].except!(:extra)
        redirect_to new_user_registration_url
      end
    end

    protected

    def find_or_create_user_from_omniauth
      auth = OmniauthResponse.new(response: request.env['omniauth.auth'])
      User.from_omniauth(auth)
    end

    # More info at:
    # https://github.com/heartcombo/devise#omniauth

    # GET|POST /resource/auth/twitter
    # def passthru
    #   super
    # end

    # GET|POST /users/auth/twitter/callback
    # def failure
    #   super
    # end

    # protected

    # The path used when OmniAuth fails
    # def after_omniauth_failure_path_for(scope)
    #   super(scope)
    # end
  end
end
