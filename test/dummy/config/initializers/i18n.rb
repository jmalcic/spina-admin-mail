# frozen_string_literal: true

# I18n default locale
Rails.application.config.i18n.default_locale = :'en-GB'

# I18n default locale
Rails.application.config.i18n.available_locales = %i[en-GB en]

# I18n fallbacks
Rails.application.config.i18n.fallbacks.map = { 'en-GB': 'en' }
