
task :watch_twitter => :environment do
  store = TweetStore.new
  TweetStream::Client.new.track('#uga','#sc','#dawgs','#gamecocks') do |status|
    if status
      
       Tweet.create(
        # :tweet_id => status_id,
        :text => status.text,
        :username => status.user.screen_name,
        :userid => status.user[:id])
        # :name => status.user.name)
        # )
      store.push(
        'id' => status[:id]
        # 'text' => status.text,
        # 'username' => status.user.screen_name,
        # 'userid' => status.user[:id],
        # 'name' => status.user.name,
        # 'received_at' => Time.now.to_i  
        )
      p status[:id]
      p status.user.name
    end
  end
end
