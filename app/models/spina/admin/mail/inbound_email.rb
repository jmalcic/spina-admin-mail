# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # Represents an inbound email
      class InboundEmail < Email
        attribute :from_addresses, :email_address, array: true

        validates :from_addresses, :message_id, :thread_id, presence: true
        validates :read, absence: true, on: :create

        after_create { mailboxes.each { |mailbox| NotificationMailer.inbound_email(self, mailbox).deliver_later } }
      end
    end
  end
end
