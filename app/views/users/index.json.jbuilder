json.array!(@users) do |user|
  json.extract! user, :id, :username, :password, :email, :uuid, :created_at, :updated_at
  json.url user_url(user, format: :json)
  json.addresses user.addresses, :id, :user_id, :address, :balance, :uuid, :created_at, :updated_at
end
