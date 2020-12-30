# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      ActiveRecord::Type.register :email_address, EmailAddressType, adapter: :postgresql
    end
  end
end
