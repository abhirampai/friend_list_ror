# frozen_string_literal: true

json.extract! friend, :id, :first_name, :last_name, :email, :phone_number, :twitter, :created_at, :updated_at
json.url friend_url(friend, format: :json)
