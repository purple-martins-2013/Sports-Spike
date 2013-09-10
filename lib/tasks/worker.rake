namespace :jobs do
  desc "Heroku worker"
  task :work do
    exec('ruby ./watch_twitter.rb run')
  end
end
