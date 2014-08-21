class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :uuid
      t.string :address
      t.string :nickname
      t.string :email
      t.string :video
      t.float :balance

      t.timestamps
    end

    add_index :addresses, :uuid, :unique => true
  end
end
