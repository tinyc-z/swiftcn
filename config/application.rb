require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SwiftcnRuby
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = Settings.TIME_ZONE
    config.i18n.default_locale = Settings.DEFAULT_LOCALE

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.autoload_paths += %W(#{config.root}/lib)
    config.eager_load_paths += ["#{config.root}/lib"]

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.generators do |g|
        g.factory_girl false
    end

    # cdn
    cdn_host = Settings.CDN_DOMAIN
    if cdn_host.present?
        config.action_controller.asset_host = cdn_host
    end

  end

  WillPaginate.per_page = Settings.PER_PAGE
  
end
