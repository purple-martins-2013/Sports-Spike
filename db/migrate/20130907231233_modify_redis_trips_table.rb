class ModifyRedisTripsTable < ActiveRecord::Migration
  def change
    remove_column :redis_trips, :macd_ema
    add_column :redis_trips, :macd, :integer
    add_column :redis_trips, :signal_line, :integer
  end
end
