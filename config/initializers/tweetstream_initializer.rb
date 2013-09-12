require 'tweetstream'

TweetStream.configure do |config|
  config.consumer_key         = ENV['TWEETSTREAM_CONSUMER_KEY']
  config.consumer_secret      = ENV['TWEETSTREAM_CONSUMER_SECRET']
  config.oauth_token          = ENV['TWEETSTREAM_OAUTH_TOKEN']
  config.oauth_token_secret   = ENV['TWEETSTREAM_OAUTH_SECRET']
  config.auth_method          = :oauth
end