class AddTimestampsToRedisTrip < ActiveRecord::Migration
  def change
    change_table(:redis_trips) { |t| t.timestamps }
  end
end
