# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # Mailer to send outbound emails
      class OutboundEmailMailer < ApplicationMailer
        # Subject can be set in your I18n file at config/locales/en.yml
        # with the following lookup:
        #
        #   en.spina.admin.mail.outbound_email_mailer.outbound_email.subject
        #
        def outbound_email
          @outbound_email = params[:outbound_email]
          @quoted_email = @outbound_email.quoted_email
          mail subject: @outbound_email.subject, to: @outbound_email.to_addresses, cc: @outbound_email.cc_addresses,
               bcc: @outbound_email.bcc_addresses, from: @outbound_email.mailboxes.collect(&:address)
        end
      end
    end
  end
end
