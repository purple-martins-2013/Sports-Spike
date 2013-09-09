teams = ['#lions', '#redwings', '#tigers']
store = TweetStore.new
task :watch_twitter => :environment do
  TweetStream::Client.new.track(teams.join(', ')) do |status|
    puts 'TweetStream initialized successfully'
    status_tag = status.entities.hashtags
    status_tag.select! { |tag| teams.include?(tag) }
    if status
    puts "about to call store.push"
      store.push(
        'hashtags' => status_tag
      )
      p status[:id]
      p status.user.name
    end
  end
end
