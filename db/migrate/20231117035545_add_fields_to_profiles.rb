# frozen_string_literal: true

class AddFieldsToProfiles < ActiveRecord::Migration[7.0]
  def change
    change_table :profiles, bulk: true do |t|
      t.string :description
      t.string :avatar_url
    end
  end
end
