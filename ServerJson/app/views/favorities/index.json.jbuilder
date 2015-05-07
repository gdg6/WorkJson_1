json.array!(@favorities) do |favority|
  json.extract! favority, :id, :event_id, :user_id
  json.url favority_url(favority, format: :json)
end
