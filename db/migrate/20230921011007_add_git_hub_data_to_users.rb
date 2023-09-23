class AddGitHubDataToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :github_username
      t.string :github_token
      t.string :profile_pic_url
    end
  end
end
