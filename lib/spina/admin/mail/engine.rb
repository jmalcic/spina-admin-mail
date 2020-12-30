# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      class Engine < ::Rails::Engine #:nodoc:
        config.before_initialize do
          ::Spina::Plugin.register do |plugin|
            plugin.name = 'mail'
            plugin.namespace = 'mail'
          end
        end
      end
    end
  end
end
