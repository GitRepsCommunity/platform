# frozen_string_literal: true

class PullRequestsController < ApplicationController
  def index
    client = GithubServices::PullRequests::Client.new
    @pull_requests = client.list
  end

  def show; end
end
