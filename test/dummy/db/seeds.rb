# frozen_string_literal: true

module Spina
  Account.first_or_create name: 'Mail', theme: 'default'
  User.first_or_create name: 'Joe', email: 'someone@someaddress.com', password: 'password', admin: true
  module Admin
    module Mail
      Mailbox.create! display_name: 'Joe\'s inbox', address: 'someone@someaddress.com'
    end
  end
end
