# frozen_string_literal: true

module GithubExplorer
  class ApiRequest < ApplicationRecord
    belongs_to :user
    enum :resource, { user: 0, repositories: 1, organizations: 2, url: 3 }
  end
end
