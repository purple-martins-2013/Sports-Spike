class AddHistogramToRedisTrips < ActiveRecord::Migration
  def change
    add_column :redis_trips, :histogram, :integer
  end
end
