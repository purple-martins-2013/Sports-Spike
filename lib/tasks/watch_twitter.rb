class TweetStream::Daemon
  def start(path, query_parameters = {}, &block)
    startmethod = super.start
    Daemons.run_proc(@app_name || 'tweetstream', multiple: true, no_pidfiles: true) do
      startmethod(path, query_parameters, &block)
    end
  end
end
teams = SearchTerm.all
store = TweetStore.new(teams)
TweetStream::Daemon.new.track(teams.pluck('hashtag').join(', ')) do |status|
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
