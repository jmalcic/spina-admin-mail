# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # Represents a mailbox
      class Mailbox < ApplicationRecord
        attribute :display_name, :string
        attribute :address, :string

        has_and_belongs_to_many :threads, class_name: 'Spina::Admin::Mail::Thread',
                                          foreign_key: :spina_admin_mail_mailbox_id,
                                          association_foreign_key: :spina_admin_mail_thread_id
        has_and_belongs_to_many :followers, class_name: 'Spina::User',
                                            foreign_key: :spina_admin_mail_mailbox_id,
                                            association_foreign_key: :spina_user_id
        has_many :emails, -> { order(:date) }, through: :threads
        has_many :inbound_emails, -> { order(:date) }, through: :threads, source: :emails,
                                                       class_name: 'Spina::Admin::Mail::InboundEmail'
        has_many :outbound_emails, -> { order(:date) }, through: :threads, source: :emails,
                                                        class_name: 'Spina::Admin::Mail::OutboundEmail'

        validates :address, :display_name, uniqueness: true, presence: true

        def parsed_address
          if changed.inquiry.any? :address, :display_name
            @parsed_address = parse_address
          else
            @parsed_address ||= parse_address
          end
        end

        private

        def parse_address
          parsed_address = ::Mail::Address.new
          parsed_address.address = address
          parsed_address.display_name = display_name
          parsed_address
        end
      end
    end
  end
end
