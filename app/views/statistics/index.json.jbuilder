json.array!(@statistics) do |statistic|
  json.extract! statistic, :id, :stat_time, :round_ant, :round_btc, :round_trans, :round_avg_btc, :round_accounts, :round_rate, :total_ant, :total_btc, :total_trans, :total_avg_btc, :total_accounts, :total_rate
  json.url statistic_url(statistic, format: :json)
end
