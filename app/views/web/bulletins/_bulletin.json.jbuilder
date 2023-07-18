# frozen_string_literal: true

json.extract! bulletin, :id, :title, :description, :image, :created_at, :updated_at
json.url bulletin_url(bulletin, format: :json)
