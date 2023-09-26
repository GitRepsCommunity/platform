# frozen_string_literal: true

class OmniauthResponse
  include ActiveModel::Model

  def initialize(response:)
    @response = response
  end

  def provider
    @response['provider']
  end

  def uid
    @response['uid']
  end

  def email
    primary_email ? primary_email['email'] : @response['info']['email']
  end

  def primary_email
    @response['extra']['all_emails'].find { |e| e['primary'] == true }
  end

  def github_username
    @response['extra']['raw_info']['login']
  end

  def github_token
    @response['credentials']['token']
  end

  def profile_pic_url
    @response['extra']['raw_info']['avatar_url']
  end
end
