require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Gign
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    Rails.application.config.middleware.use OmniAuth::Builder do
        provider :steam, "yoursteamkey"
    end
    
    WebApi.api_key = "yoursteamkey"


    I18n.locale = :fr
    I18n.default_locale = :fr
    I18n.available_locales = [:fr, :en]
    
    config.i18n.fallbacks = true
    Globalize.fallbacks = {:en => [:en, :fr], :fr => [:fr, :en]}

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :haml
      g.test_framework  false
      g.stylesheets     false
      g.javascripts     false
      g.jbuilder        false
    end
  end
end
