# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # Preview all emails at http://localhost:3000/rails/mailers/spina/admin/mail/outbound_email_mailer
      class OutboundEmailMailerPreview < ActionMailer::Preview
        # Preview this email at http://localhost:3000/rails/mailers/spina/admin/mail/outbound_email_mailer/outbound_email
        def outbound_email
          OutboundEmailMailer.with(outbound_email: OutboundEmail.first).outbound_email
        end
      end
    end
  end
end
