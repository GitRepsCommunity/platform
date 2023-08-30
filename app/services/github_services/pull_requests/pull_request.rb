# frozen_string_literal: true

module GithubServices
  module PullRequests
    class PullRequest
      include HttpHelper

      attr_reader :id, :number, :state, :title, :requested_reviewers, :issue_url, :diff_url

      def initialize(attrs)
        @attrs = attrs
        @id = @attrs.fetch(:id)
        @number = @attrs.fetch(:number)
        @state = @attrs.fetch(:state)
        @title = @attrs.fetch(:title)
        @labels = @attrs.fetch(:labels)
        @requested_reviewers = @attrs.fetch(:requested_reviewers)
        @issue_url = @attrs.fetch(:issue_url)
        @diff_url = @attrs.fetch(:diff_url)
      end

      def draft?
        @attrs.fetch(:draft)
      end

      def author
        @attrs.dig(:user, :login)
      end

      def description
        @attrs.fetch(:body)
      end

      def created_at
        @attrs.fetch(:created_at).try(:to_datetime)
      end

      def closed_at
        @attrs.fetch(:closed_at).try(:to_datetime)
      end

      def merged_at
        @attrs.fetch(:merged_at).try(:to_datetime)
      end

      def cycle_time
        return unless merged_at && created_at

        merged_at - created_at
      end

      def labels
        @labels.map { |label| { name: label.name, description: label.description } }
      end

      def changed_files
        diff = github_get_pull_request_diff
        files = diff.split('diff --git').reject { |f| f.strip.empty? }
        @changed_files = files.map { |c| ChangedFile.new content: c }
      end

      def github_get_pull_request_diff
        response = get_with_redirect(url: @diff_url)
        response.body
      end
    end
  end
end
