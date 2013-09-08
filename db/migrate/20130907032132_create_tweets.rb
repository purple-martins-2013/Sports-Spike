class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer   :tweet_id
      t.string    :text
      t.string    :username
      t.integer   :user_id
      t.string    :received_at

      t.timestamps
    end
  end
end
