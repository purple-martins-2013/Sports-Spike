class CreateRedisTrips < ActiveRecord::Migration
  def change
    create_table :redis_trips do |t|
      t.datetime :time
    end
  end
end
