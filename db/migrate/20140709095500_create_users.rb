class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uuid
      t.string :username
      t.string :password
      t.string :email

      t.timestamps
    end

    add_index :users, :uuid, :unique => true
  end
end
