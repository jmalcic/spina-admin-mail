# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # Represents an inbound email
      class OutboundEmail < Email
        attribute :read, default: true
        attribute :date, default: -> { Time.now }
        attribute :from_addresses, :email_address, array: true, default: []

        belongs_to :quoted_email, class_name: 'Spina::Admin::Mail::Email', optional: true

        # Ensure message ID is set by mailers, and quoted IDs are present
        validates :message_id, presence: true, on: :update
        # TODO: add tests
        validate :recipient_must_be_present

        after_initialize { build_thread if thread.blank? }
        after_create { OutboundEmailMailer.with(outbound_email: self).outbound_email.deliver_later }

        private

        def recipient_must_be_present
          return if [].concat(to_addresses, cc_addresses, bcc_addresses).filter_map(&:address).present?

          errors.add :base, :recipient_must_be_present
        end
      end
    end
  end
end
