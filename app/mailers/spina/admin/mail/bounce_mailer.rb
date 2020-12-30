# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # Mailer to bounce inbound emails
      class BounceMailer < ApplicationMailer
        # Subject can be set in your I18n file at config/locales/en.yml
        # with the following lookup:
        #
        #   en.spina.admin.mail.bounce_mailer.unknown_recipient.subject
        #
        def unknown_recipient(*recipients)
          @message = params[:email].mail
          @unknown_recipients = recipients
          set_content
          set_attachments
          mail subject: @message.subject, to: @message.to_addresses, from: @message.from_address,
               cc: @message.cc_addresses, bcc: @message.bcc_addresses
        end

        private

        def set_content
          @html = @message.html_part || @message.text_part || @message
          @text = @message.text_part || @message.html_part || @message
        end

        def set_attachments
          @message.attachments.each { |attachment| attachments[attachment.filename] = attachment.body.decoded }
        end
      end
    end
  end
end
