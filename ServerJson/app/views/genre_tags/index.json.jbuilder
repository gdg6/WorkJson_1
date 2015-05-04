json.array!(@genre_tags) do |genre_tag|
  json.extract! genre_tag, :id, :title
  json.url genre_tag_url(genre_tag, format: :json)
end
