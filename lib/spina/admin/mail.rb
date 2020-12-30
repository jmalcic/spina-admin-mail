# frozen_string_literal: true

require 'spina'
require 'spina/admin/mail/engine'
require 'rails-i18n'

module Spina
  module Admin
    module Mail #:nodoc:
      def self.table_name_prefix
        'spina_admin_mail_'
      end
    end
  end
end
