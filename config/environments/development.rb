SportsSpike::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
end
  ENV['TWEETSTREAM_CONSUMER_KEY'] = 'EJboNtzlFa0wX7FNjZtlg'
  ENV['TWEETSTREAM_CONSUMER_SECRET'] = 'z1n9xc4T8BsLPmnT6bTnTKS75ZmFXm01kpqrzIV4ho'
  ENV['TWEETSTREAM_OAUTH_TOKEN'] = '1732712186-mzZtp0RcXDKFOKUyek7fv3W1R3x2EuJqPKBF9Dn'
  ENV['TWEETSTREAM_OAUTH_SECRET'] = 'oksEY9j5FVrSZc9vWDxr7fdsY9sKsT91TyqKhHV7GxQ'
  ENV["REDISTOGO_URL"] = 'redis://redistogo:91bc233362f01799527a5f0c9c30859c@koi.redistogo.com:9898/'
