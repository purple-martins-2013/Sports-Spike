class AddGameStatusToSpikes < ActiveRecord::Migration
  def change
    add_column :spikes, :game_status, :string
  end
end
