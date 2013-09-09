teams = SearchTerm.all
store = TweetStore.new(teams)
task :watch_twitter => :environment do
  TweetStream::Client.new.track(teams.pluck('term').join(', ')) do |status|
    puts 'TweetStream initialized successfully'
    status_tag = status.entities.hashtags
    status_tag.select! { |tag| teams.include?(tag) }
    if status
    puts "about to call store.push"
      store.push(status_tag)
      store.check_timer
      p status[:id]
      p status.user.name
    end
  end
end
