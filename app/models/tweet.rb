class Tweet <ActiveRecord::Base
  
 def index
  @data = data
 end

  def self.create_tweets
   TweetStream::Client.new.track('#giants') do |status|
      if status.text
        p status[:id]
         Tweet.create(
          :tweet_id => status[:id],
          :text => status.text,
          :username => status.user.screen_name,
          :userid => status.user[:id],
          :name => status.user.name
          )
      end
    end
  end

end
