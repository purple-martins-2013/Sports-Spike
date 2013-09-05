class AddEventIdToSpike < ActiveRecord::Migration
  def change
    add_column :spikes, :event_id, :integer
  end
end
