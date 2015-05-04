json.array!(@tags_users) do |tags_user|
  json.extract! tags_user, :id, :context
  json.url tags_user_url(tags_user, format: :json)
end
