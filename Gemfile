source 'https://rubygems.org'

ruby '2.2.1'

gem 'rails', '~> 4.1.6'

# Cron
gem 'whenever', :require => false

# Environment vars and configs
gem 'dotenv-rails'
gem 'dotenv-deployment'


#gem 'catarse_api', path: '~/code/catarse_api'
gem 'catarse_api', github: 'catarse/catarse_api'
gem 'protected_attributes', '~> 1.0.5' # When upgrade to strong_parameters, remove this gem.
gem 'rails-observers', '~> 0.1.2'
gem 'activerecord-session_store'

gem 'sinatra'
gem 'sidekiq', require: nil

# Turns every field on a editable one
gem "best_in_place", :git => "git://github.com/bernat/best_in_place", ref: "ee95961e639022e6aa528704b8cb4789596ea61b"

# State machine for attributes on models
gem 'state_machine', require: 'state_machine/core'

# paranoid stuff
gem 'paper_trail', github: 'airblade/paper_trail'

# Errors
gem 'rollbar', '~> 1.2.4'

# Monitoring
gem 'newrelic_rpm'

# Database and data related
gem 'pg', '0.17.1'
gem 'postgres-copy'
gem 'pg_search'
gem 'i18n_alchemy'

gem 'schema_plus'
gem 'chartkick'
gem 'catarse_settings_db', '>= 0.1.0'

# Notifications
gem 'user_notifier', '~> 0.0.5'

# Mixpanel for backend tracking
gem 'mixpanel-ruby'

# Payment engines
gem 'catarse_stripe', :git => 'git@github.com:Codebeef/catarse_stripe.git'
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
gem 'catarse_contribution_validator', github: 'catarse/catarse_contribution_validator'

# Decorators
gem 'draper'

# Frontend stuff
gem 'slim-rails'
gem 'jquery-rails'
gem 'browser'
gem "cocoon"

# Static pages
gem 'high_voltage'

# Authentication and Authorization
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook', '1.4.0'
gem 'devise'
gem 'ezcrypto'
gem 'pundit'

# Email marketing
gem 'letter_opener_web', '~> 1.2.0'
gem 'catarse_monkeymail', '>= 0.1.6'

# HTML manipulation and formatting
gem 'simple_form'
gem 'mail_form'
gem "auto_html"
gem "RedCloth"
gem 'kaminari'
gem 'redactor-rails'

# Uploads
gem 'carrierwave', '~> 0.10.0'
gem "mini_magick"
gem 'rmagick', :require => 'RMagick'

# Other Tools
gem 'to_xls'
gem 'ranked-model'
gem 'feedjira'
gem 'inherited_resources',        '~> 1.4.1'
gem 'has_scope', '~> 0.6.0.rc'
gem 'spectator-validates_email',  require: 'validates_email'
gem 'video_info', '>= 1.1.1'
gem 'httparty', '~> 0.6.1' # this version is required by moip gem, otherwise payment confirmation will break

# Translations
gem 'http_accept_language'
gem 'routing-filter', '~> 0.4.0.pre'

group :production do
  # Gem used to handle image uploading
  gem 'fog', '>= 1.3.1'

  # Workers, forks and all that jazz
  gem 'unicorn'

  # Enabling Gzip on Heroku
  # If you don't use Heroku, please comment the line below.
  # gem 'heroku-deflater', '>= 0.4.1'

  # Make heroku serve static assets and loggin with stdout
  #gem 'rails_on_heroku'
  #gem 'rails_12factor'

  # Using dalli and memcachier have not presented significative performance gains
  # Probably this is due to our pattern of cache usage
  # + the lack of concurrent procs in our deploy
  #gem 'memcachier'
  #gem 'dalli'
end
group :development do
  gem "letter_opener"
  gem 'foreman'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'thin'
  # Uncomment only for optimization, should be commented on master branch
  # gem 'rack-mini-profiler'

  # Deployment
  gem 'capistrano'
  gem 'capistrano-rails', '~> 1.1'

  gem 'i18n-tasks', '~> 0.7.13'
end

group :test, :development do
  gem 'rspec-rails', '~> 3.1'
  gem 'rspec-mocks'
  gem 'rspec-its'
  gem 'rspec-collection_matchers'
  gem 'pry'
  gem 'jasmine-rails'
end

group :test do
  gem 'fakeweb'
  gem 'poltergeist'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'capybara',   '~> 2.2.0'
  gem 'coveralls', require: false
  gem 'selenium-webdriver'
end

gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem "compass-rails"
gem 'uglifier'
gem 'compass-960-plugin'
gem 'sprockets', '~> 2.10.1'

# FIXME: Not-anymore-on-development
# Gems that are with 1 or more years on the vacuum
gem 'weekdays'
