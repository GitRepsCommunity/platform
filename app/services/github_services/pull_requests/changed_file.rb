# frozen_string_literal: true

module GithubServices
  module PullRequests
    class ChangedFile
      def initialize(content:)
        @parts = content.split("\n@@")
      end

      def file
        @parts[0]
      end

      def diff_chunks
        @diff_chunks = @parts[1..].map { |c| DiffChunk.new content: c }
      end
    end
  end
end
