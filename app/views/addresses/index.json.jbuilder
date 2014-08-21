json.array!(@addresses) do |address|
  json.extract! address, :id, :uuid, :nickname, :video, :address, :balance, :created_at, :updated_at
  json.url address_url(address, format: :json)
end
