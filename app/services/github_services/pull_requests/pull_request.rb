# frozen_string_literal: true

module GithubServices
  module PullRequests
    class PullRequest
      include HttpHelper

      attr_reader :id, :number, :state, :title, :author, :description, :created_at, :closed_at, :merged_at,
                  :requested_reviewers, :issue_url, :diff_url

      def initialize(attrs)
        @id = attrs.fetch(:id)
        @number = attrs.fetch(:number)
        @state = attrs.fetch(:state)
        @draft = attrs.fetch(:draft)
        @title = attrs.fetch(:title)
        @author = attrs.dig(:user, :login)
        @description = attrs.fetch(:body)
        @labels = attrs.fetch(:labels)
        @created_at = attrs.fetch(:created_at).try(:to_datetime)
        @closed_at = attrs.fetch(:closed_at).try(:to_datetime)
        @merged_at = attrs.fetch(:merged_at).try(:to_datetime)
        @requested_reviewers = attrs.fetch(:requested_reviewers)
        @issue_url = attrs.fetch(:issue_url)
        @diff_url = attrs.fetch(:diff_url)
      end

      def draft?
        @draft
      end

      def cycle_time
        return unless @merged_at && @created_at

        @cycle_time = @merged_at - @created_at
      end

      def labels
        @labels.map { |_lable| { name: label.name, description: label.description } }
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
