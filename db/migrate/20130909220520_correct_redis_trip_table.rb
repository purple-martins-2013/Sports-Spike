class CorrectRedisTripTable < ActiveRecord::Migration
  def change
    remove_column :redis_trips, :time
    add_column :redis_trips, :search_term_id, :integer
  end
end
