class AssociateSpikeToRedisTrip < ActiveRecord::Migration
  def change
    add_column :spikes, :redis_trips_id, :integer
    remove_column :spikes, :event_id
    remove_column :spikes, :date_time
    remove_column :spikes, :peak_velocity
  end
end
