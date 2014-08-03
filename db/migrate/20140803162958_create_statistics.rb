class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.datetime :stat_time
      t.float :round_ant
      t.float :round_btc
      t.integer :round_trans
      t.float :round_avg_btc
      t.integer :round_accounts
      t.float :round_rate
      t.float :total_ant
      t.float :total_btc
      t.integer :total_trans
      t.float :total_avg_btc
      t.integer :total_accounts
      t.float :total_rate

      t.timestamps
    end
  end
end
