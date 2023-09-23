# frozen_string_literal: true

class User < ApplicationRecord
  encrypts :github_token, deterministic: false
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable,
         :registerable,
         :rememberable,
         :validatable,
         :omniauthable, omniauth_providers: %i[github]

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth['provider'], uid: auth['uid']) do |user|
      primary_email_data = auth['extra']['all_emails'].find { |email_hash| email_hash['primary'] == true }
      user.email = primary_email_data ? primary_email_data['email'] : auth['info']['email']
      user.password = Devise.friendly_token[0, 20]
      user.github_username = auth['extra']['raw_info']['login']
      user.github_token = auth['credentials']['token']
      user.profile_pic_url = auth['extra']['raw_info']['avatar_url']

      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
