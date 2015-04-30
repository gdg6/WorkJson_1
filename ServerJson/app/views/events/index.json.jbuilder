json.array!(@events) do |event|
  json.extract! event, :id, :EventId, :Name, :Adress, :Date, :Time, :Description, :Price, :Popularity
  json.url event_url(event, format: :json)
end
