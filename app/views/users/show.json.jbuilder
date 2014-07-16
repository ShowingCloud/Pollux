json.extract! @user, :id, :username, :password, :email, :created_at, :updated_at
json.addresses @user.addresses, :id, :user_id, :address, :balance, :uuid, :created_at, :updated_at
