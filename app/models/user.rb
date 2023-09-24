# frozen_string_literal: true

class User < ApplicationRecord
  encrypts :github_token, deterministic: false

  devise :database_authenticatable,
         :recoverable,
         :registerable,
         :rememberable,
         :validatable,
         :omniauthable, omniauth_providers: %i[github]

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth['provider'], uid: auth['uid']) do |user|
      user.assign_email(auth)
      user.assign_password
      user.assign_github_details(auth)
    end
  end

  def assign_email(auth)
    primary_email_data = auth['extra']['all_emails'].find { |email_hash| email_hash['primary'] }
    self.email = primary_email_data ? primary_email_data['email'] : auth['info']['email']
  end

  def assign_password
    self.password = Devise.friendly_token[0, 20]
  end

  def assign_github_details(auth)
    self.github_username = auth['extra']['raw_info']['login']
    self.github_token = auth['credentials']['token']
    self.profile_pic_url = auth['extra']['raw_info']['avatar_url']
  end
end
