# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # Preview all emails at http://localhost:3000/rails/mailers/spina/admin/mail/notification_mailer
      class NotificationMailerPreview < ActionMailer::Preview
        # Preview this email at http://localhost:3000/rails/mailers/spina/admin/mail/notification_mailer/inbound_email
        def inbound_email
          inbound_email = InboundEmail.first
          mailbox = inbound_email.mailboxes.first
          NotificationMailer.inbound_email(inbound_email, mailbox)
        end
      end
    end
  end
end
