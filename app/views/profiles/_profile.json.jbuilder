# frozen_string_literal: true

json.extract! profile, :id, :created_at, :updated_at
json.url profile_url(profile, format: :json)
