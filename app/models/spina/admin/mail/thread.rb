# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # Represents a thread of messages
      class Thread < ApplicationRecord
        # TODO: add test
        scope :orphaned, -> { left_outer_joins(:emails).where(spina_admin_mail_emails: { id: nil }) }

        has_and_belongs_to_many :mailboxes, class_name: 'Spina::Admin::Mail::Mailbox',
                                            foreign_key: :spina_admin_mail_thread_id,
                                            association_foreign_key: :spina_admin_mail_mailbox_id
        has_many :emails, class_name: 'Spina::Admin::Mail::Email', dependent: :destroy

        validates :mailbox_ids, presence: true

        def self.destroy_orphans
          orphaned.destroy_all
        end

        # TODO: add test
        def name
          return unless emails.any?

          emails.first.subject
        end

        # TODO: add test
        def correspondents
          return [] unless emails.any?

          emails.collect(&:correspondents).inject(:+).uniq(&:to_s)
        end

        # TODO: add test
        def latest_email_date
          return unless emails.any?

          emails.last.date
        end
      end
    end
  end
end
