class AddColumnsToRedisTrips < ActiveRecord::Migration
  def change
    add_column :redis_trips, :short_ema, :integer
    add_column :redis_trips, :long_ema, :integer
    add_column :redis_trips, :macd_ema, :integer
  end
end
