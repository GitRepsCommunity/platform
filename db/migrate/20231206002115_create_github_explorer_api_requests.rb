# frozen_string_literal: true

class CreateGithubExplorerApiRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :github_explorer_api_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :resource, null: false, default: 0
      t.string :query
      t.json :response
      t.string :url

      t.timestamps
    end
  end
end
