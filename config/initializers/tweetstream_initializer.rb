require 'tweetstream'

TweetStream.configure do |config|
  config.consumer_key         = TWEETSTREAM_CONSUMER_KEY  
  config.consumer_secret      = TWEETSTREAM_CONSUMER_SECRET
  config.oauth_token          = TWEETSTREAM_OAUTH_TOKEN
  config.oauth_token_secret   = TWEETSTREAM_OAUTH_SECRET
  config.auth_method          = :oauth
end