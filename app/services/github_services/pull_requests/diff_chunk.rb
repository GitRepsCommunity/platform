# frozen_string_literal: true

module GithubServices
  module PullRequests
    class DiffChunk
      attr_reader :deletions, :additions

      def initialize(content:)
        @parts = content.strip.split("\n")
        calculate_stats
      end

      def header
        @header = @parts[0].split(' @@')[0]
      end

      def lines
        @lines = @parts[1..]
      end

      def calculate_stats
        stats = header.split
        @deletions = stats[0].split(',')[1]
        @additions = stats[1].split(',')[1]
      end
    end
  end
end
