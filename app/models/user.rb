# frozen_string_literal: true

class User < ApplicationRecord
  encrypts :github_token, deterministic: false

  devise :database_authenticatable,
         :recoverable,
         :registerable,
         :rememberable,
         :validatable,
         :omniauthable, omniauth_providers: %i[github]

  has_many :profiles, dependent: :destroy
  has_many :api_requests, dependent: :destroy, class_name: 'GithubExplorer::ApiRequest'

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.password = Devise.friendly_token[0, 20]
      user.email = auth.email
      user.github_username = auth.github_username
      user.github_token = auth.github_token
      user.profile_pic_url = auth.profile_pic_url
    end
  end
end
