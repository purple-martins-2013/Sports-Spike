
task :watch_twitter => :environment do
  store = TweetStore.new
  TweetStream::Client.new.track('#Trojans','#USC','#Wazzu') do |status|
    puts 'TweetStream initialized successfully'
    if status
       Tweet.create(
        :text => status.text,
        :username => status.user.screen_name,
        :user_id => status.user[:id]
        )
      store.push(
        'id' => status[:id]
        )
      p status[:id]
      p status.user.name
    end
  end
end
