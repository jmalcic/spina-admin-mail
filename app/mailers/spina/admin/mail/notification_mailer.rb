# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # Mailer to notify users
      class NotificationMailer < ApplicationMailer
        default from: 'notifications@example.com'

        # Subject can be set in your I18n file at config/locales/en.yml
        # with the following lookup:
        #
        #   en.spina.admin.mail.notification_mailer.inbound_email.subject
        #
        def inbound_email(email, mailbox)
          @inbound_email = email
          @mailbox = mailbox
          mail subject: "Fw: #{@inbound_email.subject}", to: mailbox.followers.collect(&:email),
               from: mailbox.address
        end
      end
    end
  end
end
