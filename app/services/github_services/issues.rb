# frozen_string_literal: true

module GithubServices
  class Issues
    def initialize(oauth_token: ENV.fetch('GITHUB_OAUTH_TOKEN'))
      @client = Github.new oauth_token:
    end

    def list(**kwargs)
      response = @client.issues.list kwargs
      response.body
    end
  end
end
