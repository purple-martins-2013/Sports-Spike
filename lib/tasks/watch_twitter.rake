
task :watch_twitter => :environment do

store = TweetStore.new
TweetStream::Client.new.track('#broncos', '#ravens') do |status|
  if status.text
    p status[:id]
    store.push(
      'id' => status[:id],
      # 'text' => status.text,
      # 'username' => status.user.screen_name,
      # 'userid' => status.user[:id],
      # 'name' => status.user.name,
      'received_at' => Time.new.to_i  
      )
  end
end

end
