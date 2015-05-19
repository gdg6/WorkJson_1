json.array!(@characters) do |character|
  json.extract! character, :id, :title, :general
  json.url character_url(character, format: :json)
end
