require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ThemingServiceRails5Api
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    ActiveModel::Serializer.config.adapter = :json_api
    
    # Rails 5 config
    Rails.application.config.active_record.belongs_to_required_by_default = true
    
    # Halt for callback
    ActiveSupport.halt_callback_chains_on_return_false = false
    
    # Password filter
    Rails.application.config.filter_parameters += [:password]
    
    # Use mimtype
    Mime::Type.register "application/vnd.api+json", :json
    
    # SSL for subdomains
    Rails.application.config.ssl_options = { hsts: { subdomains: true } }
    
    # Preservs time zone
    ActiveSupport.to_time_preserves_timezone = true

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :put, :patch, :delete, :post, :options]
      end
    end
  end
end
