class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :uuid
      t.integer :user_id
      t.string :address
      t.float :balance

      t.timestamps
    end
  end
end