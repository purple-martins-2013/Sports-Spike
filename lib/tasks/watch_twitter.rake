namespace :jobs do
  task :work => :environment do
    p 'here in log'
    teams = SearchTerm.all
    store = TweetStore.new(teams)
    ENV.each do |key, var|
      p key, var if key.include?("TWEET")
    end
    TweetStream::Client.new.track(teams.pluck('hashtag').join(', ')) do |status|
      puts 'TweetStream initialized successfully'
      tags = []
      status.hashtags.each { |tag| tags << tag.text }
      tags.map! { |tag| "\##{tag}"}
      tags.select! { |tag| teams.map { |x| x.hashtag.downcase }.include?(tag.downcase) }
      if status
        p status.created_at
        puts "about to call store.push"
        store.push(tags.uniq)
        store.check_timer
        p status.user.name
      end
    end
  end
end
