# frozen_string_literal: true

module GithubExplorer
  class ApiRequest < ApplicationRecord
    belongs_to :user
    enum :resource, { user: 0, repositories: 1, organizations: 2, url: 3 }

    def send_request_and_save!
      self.response = send_request
      save!
    end

    def send_request
      case resource
      when 'url'
        octokit_client.get(url)
      else
        octokit_client.send(resource)
      end
    end

    def octokit_client
      Octokit::Client.new(access_token: user.github_token, per_page: 100)
    end
  end
end
