json.array!(@users) do |user|
  json.extract! user, :id, :UserId, :Login, :Email, :Password, :CharacterName, :City, :Admin
  json.url user_url(user, format: :json)
end
