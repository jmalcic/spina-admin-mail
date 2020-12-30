# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # Represents an email
      class Email < ApplicationRecord
        # TODO: add test
        default_scope -> { order(:date) }
        # TODO: add test
        scope :latest, -> { order(:date).last }

        attribute :to_addresses, :email_address, array: true
        attribute :cc_addresses, :email_address, array: true
        attribute :bcc_addresses, :email_address, array: true

        enum priority: { highest: 0, high: 1, normal: 2, low: 3, lowest: 4 }

        belongs_to :thread, inverse_of: 'emails', class_name: 'Spina::Admin::Mail::Thread'
        has_many :mailboxes, through: :thread
        has_many :thread_predecessors,
                 ->(inbound_email) { where('date < ?', inbound_email.date).where.not(id: inbound_email.id).order(:date) },
                 through: :thread, source: :emails, class_name: 'Spina::Admin::Mail::Email'
        has_many :thread_successors,
                 ->(inbound_email) { where('date > ?', inbound_email.date).where.not(id: inbound_email.id).order(:date) },
                 through: :thread, source: :emails, class_name: 'Spina::Admin::Mail::Email'

        has_rich_text :message

        accepts_nested_attributes_for :thread, update_only: true

        validates :to_addresses, :subject, :message, presence: true
        validates :message_id, uniqueness: true, allow_blank: true
        validates_associated :thread

        after_destroy { Thread.destroy_orphans }

        def correspondents
          addresses = to_addresses + from_addresses + cc_addresses + bcc_addresses
          addresses.uniq(&:to_s)
          addresses.delete_if { |address| Mailbox.find_by address: address.to_s }
        end
      end
    end
  end
end
