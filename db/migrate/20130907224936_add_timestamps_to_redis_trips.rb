class AddTimestampsToRedisTrips < ActiveRecord::Migration
  def change
    add_column :redis_trips, :timestamps, :time
  end
end
