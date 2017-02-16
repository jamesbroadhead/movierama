Rails.application.configure do
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

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  OmniAuth.config.full_host = "https://movierama.dev"

  # Select an email provider from ['log_only', 'mailgun']
  # TODO: config validation
  config.email_provider = 'mailgun'

  config.email_mailgun_api_key = 'key-c37046d1e571eb78c835613c272ee543'
  config.email_mailgun_domain = 'sandbox3ceb4f2a8a3c4f189c9d38cec78a16ca.mailgun.org'

	config.action_mailer.delivery_method = :smtp
	# SMTP settings for mailgun
	ActionMailer::Base.smtp_settings = {
		:port           => 587,
		:address        => "smtp.mailgun.org",
		:domain         => 'sandbox3ceb4f2a8a3c4f189c9d38cec78a16ca.mailgun.org',
		:user_name      => 'postmaster@sandbox3ceb4f2a8a3c4f189c9d38cec78a16ca.mailgun.org',

		:password       => '24c80f55a887e54d9fd3d8d1b7524ca4',
		:authentication => :plain,
	}
end
