# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # Mailbox for emails to teams and the whole organisation
      class SharedMailbox < ApplicationMailbox
        before_processing :require_known_recipient, :update_or_create_thread

        MAPPED_ATTRIBUTES = [:subject, :reply_to, :date, :message_id,
                             message: :body, from_addresses: :from, to_addresses: :to, cc_addresses: :cc,
                             bcc_addresses: :bcc].freeze

        def process
          InboundEmail.create(inbound_email_attributes)
        end

        private

        def require_known_recipient
          return if associated_mailboxes.any?

          bounce_with BounceMailer.with(email: inbound_email).unknown_recipient(*unknown_recipients)
        end

        def unknown_recipients
          inbound_email.mail.recipients_addresses.filter { |address| Mailbox.pluck(:address).include? address }
        end

        def update_or_create_thread
          thread.mailboxes << associated_mailboxes
          thread.save
        end

        def thread
          message_ids = [inbound_email.mail.in_reply_to, inbound_email.mail.references&.last]
          @thread ||= Thread.joins(:emails).where(spina_admin_mail_emails: { message_id: message_ids }).first_or_create
        end

        def associated_mailboxes
          @mailboxes ||= Mailbox.where address: inbound_email.mail.recipients
        end

        def parse_priority(priority)
          return unless priority.present?

          InboundEmail.priorities.keys[priority.to_i.pred]
        end

        def inbound_email_attributes
          attributes = { read: false, priority: parse_priority(mail.header['X-Priority']), thread: thread }
          MAPPED_ATTRIBUTES.each do |element|
            case element
            when Symbol then attributes[element] = mail.send(element)
            when Hash then element.each { |key, value| attributes[key] = mail.send(value) }
            else return nil
            end
          end
          attributes.compact
        end
      end
    end
  end
end
