# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.18' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install  
  config.gem 'rails', :source => 'http://gemcutter.org', :version => '2.3.18'
  config.gem 'rake', :source => 'http://gemcutter.org', :version => '0.8.7'
  config.gem 'authlogic', :source => 'http://gemcutter.org'
  config.gem 'declarative_authorization', :source => 'http://gemcutter.org'
  config.gem 'will_paginate', :source => 'http://gemcutter.org'
  config.gem 'repeated_auto_complete', :source => 'http://gemcutter.org'
  config.gem 'acts_as_indexed', :source => 'http://gemcutter.org'
  config.gem 'pdfkit', :source => 'http://gemcutter.org', :version => '0.5.1'
  config.gem 'aasm', :source => 'http://gemcutter.org'
  config.gem 'paper_trail', :source => 'http://gemcutter.org', :version => '1.6.4'
  config.gem 'whenever', :source => 'http://gemcutter.org' 
  config.gem 'searchlogic', :source => 'http://gemcutter.org', :version => '2.4.19' 
  config.gem 'delayed_job', :source => 'http://gemcutter.org', :version => '2.0.7'
  config.gem 'differ', :source => 'http://gemcutter.org'
  config.gem 'to_xls', :source => 'http://gemcutter.org'
  config.gem 'ezprint', :source => 'http://gemcutter.org'
  config.gem 'acts_as_list', :source => 'http://gemcutter.org', :version => '0.1.2'
  config.gem 'riddle', :source => 'http://gemcutter.org', :version => '1.5.6'
  config.gem 'thinking-sphinx', :lib => 'thinking_sphinx', :source => 'http://gemcutter.org', :version => '1.4.5'
  config.gem 'flying-sphinx', :source => 'http://gemcutter.org', :version => '0.7.0'
  config.gem 'wicked_pdf', :source => 'http://gemcutter.org', :version => '0.7.5'
  config.gem 'fastercsv', :source => 'http://gemcutter.org', :version => '1.5.5' 
  config.gem 'openssl-nonblock', :source => 'http://gemcutter.org', :version => '0.2.1' 
  config.gem 'net-ssh', :source => 'http://gemcutter.org', :version => '2.0.23' 

  
  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
  config.after_initialize do
    ActionController::Base.asset_host = Proc.new do |source, request|
      if request.format == 'pdf'
        "file://#{Rails.root.join('public')}"
      end
    end
  end  

  # middleware for pdf
#  config.middleware.use "PDFKit::Middleware", :print_media_type => true

  # mail settings
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { :host => "localhost:3000" }    

end
