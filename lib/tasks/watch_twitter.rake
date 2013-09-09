
task :watch_twitter => :environment do
  store = TweetStore.new
  TweetStream::Client.new.track('#Cowboys','#Giants') do |status|
    puts 'TweetStream initialized successfully'
    if status
       Tweet.create(
        :text => status.text,
        :username => status.user.screen_name,
        :user_id => status.user[:id]
        )
      puts "about to call store.push"
      store.push(
        'id' => true
        )
      p status[:id]
      p status.user.name
    end
  end
end
