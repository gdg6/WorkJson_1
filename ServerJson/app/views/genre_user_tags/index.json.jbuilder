json.array!(@genre_user_tags) do |genre_user_tag|
  json.extract! genre_user_tag, :id, :title
  json.url genre_user_tag_url(genre_user_tag, format: :json)
end
