# frozen_string_literal: true

require 'test_helper'
require 'minitest/mock'

class PullReqestsTest < ActiveSupport::TestCase
  RESPONSE = {
    id: 1,
    number: 25,
    state: 1,
    draft: true,
    title: 'PR Title',
    user: { login: 'username' },
    body: 'PR description',
    labels: [],
    created_at: '',
    closed_at: '',
    merged_at: '',
    requested_reviewers: [],
    issue_url: '',
    diff_url: 'https://github.com/GitRepsCommunity/platform/pull/17.diff'
  }.freeze

  test 'github pull request client' do
    client = GithubServices::PullRequests::Client.new

    client.stub(:github_get_pull_request, {}) do
      assert_raises ArgumentError do
        client.get
      end

      assert_raises KeyError do
        client.get number: 25
      end
    end
  end

  test 'pull request' do
    pr = GithubServices::PullRequests::PullRequest.new RESPONSE
    assert_equal pr.id, 1
    assert_equal pr.number, 25
    assert_equal pr.title, 'PR Title'
    assert_equal pr.author, 'username'
    assert_equal pr.description, 'PR description'
    assert_equal pr.labels, []
    assert pr.draft?
    assert_nil pr.cycle_time

    diff = "diff --git a/first/file.rb\ndiff --git a/second/file.rb"
    pr.stub(:github_get_pull_request_diff, diff) do
      assert_equal pr.changed_files.count, 2
    end
  end

  test 'changed file' do
    content = " a/CODEOWNERS b/CODEOWNERS\nnew file mode 100644\n" \
              "index 0000000..143c600\n--- /dev/null\n+++ b/CODEOWNERS\n" \
              "@@ -0,0 +1,5 @@\n+# These owners will be the default owners " \
              "for everything in\n+# the repo. Unless a later match takes " \
              "precedence,\n+# these owners will be requested for review when " \
              "someone\n+# opens a pull request.\n+* @GitRepsCommunity/staff\n"
    changed_file = GithubServices::PullRequests::ChangedFile.new(content:)

    expected = " a/CODEOWNERS b/CODEOWNERS\nnew file mode 100644\n" \
               "index 0000000..143c600\n--- /dev/null\n+++ b/CODEOWNERS"
    assert_equal expected, changed_file.file
    assert_equal 1, changed_file.diff_chunks.count
  end

  test 'diff chunk' do
    content = " -0,0 +1,5 @@\n+# These owners will be the default owners for " \
              "everything in\n+# the repo. Unless a later match takes " \
              "precedence,\n+# these owners will be requested for review " \
              "when someone\n+# opens a pull request.\n+* @GitRepsCommunity/staff\n"
    diff_chunk = GithubServices::PullRequests::DiffChunk.new(content:)
    assert_equal '-0,0 +1,5', diff_chunk.header
    assert_equal 5, diff_chunk.lines.count

    diff_chunk.calculate_stats
    assert_equal '0', diff_chunk.deletions
    assert_equal '5', diff_chunk.additions
  end
end
