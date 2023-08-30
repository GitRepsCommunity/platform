# frozen_string_literal: true

module GithubServices
  module PullRequests
    class Client
      # Usage:
      # pull_requests = GithubServices::PullRequests::Client.new
      # pr = pull_requests.get number: 25

      def initialize(org: 'GitRepsCommunity', repo: 'platform')
        @org = org
        @repo = repo
        @client = Github.new
      end

      def get(number:)
        pull_request = github_get_pull_request(number:)
        PullRequest.new pull_request
      end

      def list
        pull_requests = github_list_pull_requests state: 'all'
        pull_requests.map do |pull_request|
          PullRequest.new pull_request
        end
      end

      # def comments(number:)
      #   response = @client.pull_requests.comments.list @org, @repo, number: number
      #   response.body
      #   #   id
      #   #   pull_request_review_id
      #   #   user.login
      #   #   created_at
      #   #   path
      #   #   diff_hunk
      #   #   body
      #   #   reactions.total_count
      #   #   reactions['+1']
      #   #   reactions['-1']
      #   #   reactions['laugh']
      #   #   reactions['hooray']
      #   #   reactions['confused']
      #   #   reactions['heart']
      #   #   reactions['rocket']
      #   #   reactions['eyes']
      # end

      # def reviews(number:)
      #   response = @client.pull_requests.reviews.list @org, @repo, number: number
      #   response.body
      # end

      def github_get_pull_request(number:)
        response = @client.pull_requests.get @org, @repo, number
        response.body
      end

      def github_list_pull_requests(**kwargs)
        response = @client.pull_requests.list @org, @repo, kwargs
        response.body
      end
    end
  end
end
