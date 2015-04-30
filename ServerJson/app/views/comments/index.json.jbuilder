json.array!(@comments) do |comment|
  json.extract! comment, :id, :OwnerUser, :Body
  json.url comment_url(comment, format: :json)
end
