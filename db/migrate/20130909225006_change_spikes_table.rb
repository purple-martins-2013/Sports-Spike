class ChangeSpikesTable < ActiveRecord::Migration
  def change
    rename_column :spikes, :redis_trips_id, :redis_trip_id
  end
end
