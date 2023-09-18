# frozen_string_literal: true

class AddOmniauthToUsers < ActiveRecord::Migration[7.0]
  change_table :users, bulk: true do |t|
    t.column :provider, :string
    t.column :uid, :string
  end
end
