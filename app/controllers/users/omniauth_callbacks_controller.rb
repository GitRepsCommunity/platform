# frozen_string_literal: true

<<<<<<< HEAD
module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    layout 'authentication', only: %i[new create]

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
=======
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  layout 'authentication', only: %i[new create]

  # You should also create an action method in this controller like this:
  def github
    # see app/models/user.rb:
    # @user = User.from_omniauth(request.env["omniauth.auth"])
    puts('GITHUB ACTION')
    puts(request.env["omniauth.auth"])
    redirect_to edit_user_registration_url
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
>>>>>>> 3a5fb34 (Added configuration in controllers and models for Github omniauth. Requires further work and review.)
end
