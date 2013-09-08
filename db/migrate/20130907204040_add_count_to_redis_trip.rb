class AddCountToRedisTrip < ActiveRecord::Migration
  def change
    add_column :redis_trips, :tweet_count, :integer
  end
end
