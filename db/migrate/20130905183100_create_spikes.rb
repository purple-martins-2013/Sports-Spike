class CreateSpikes < ActiveRecord::Migration
  def change
    create_table :spikes do |t|
      t.datetime     :date_time
      t.integer      :peak_velocity

      t.timestamps
    end
  end
end
