# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Mail
      class MailboxTest < ActiveSupport::TestCase
        setup do
          @mailbox = spina_admin_mail_mailboxes :unimark_mailbox
          @alternate_mailbox = spina_admin_mail_mailboxes :senate_mailbox
        end

        test 'has and belongs to many threads' do
          assert @mailbox.threads.present?
        end

        test 'has and belongs to many followers' do
          assert @mailbox.followers.present?
        end

        test 'has many emails' do
          assert @mailbox.emails.present?
        end

        test 'valid mailbox is valid' do
          assert @mailbox.valid?
        end

        test 'mailbox attributes must not be empty' do
          mailbox = Mailbox.new
          assert mailbox.invalid?
          assert_equal [I18n.translate('errors.messages.blank')], mailbox.errors[:address]
          assert_equal [I18n.translate('errors.messages.blank')], mailbox.errors[:display_name]
        end

        test 'mailbox address and display name must be unique' do
          @mailbox.address = @alternate_mailbox.address
          @mailbox.display_name = @alternate_mailbox.display_name
          assert @mailbox.invalid?
          assert_equal [I18n.translate('errors.messages.taken')], @mailbox.errors[:address]
          assert_equal [I18n.translate('errors.messages.taken')], @mailbox.errors[:display_name]
        end

        test 'parsed address are set for initial values' do
          assert_equal @mailbox.display_name, @mailbox.parsed_address.display_name
          assert_equal @mailbox.address, @mailbox.parsed_address.address
        end

        test 'parsed address are updated for changed values' do
          @mailbox.display_name = 'Someone Else'
          @mailbox.address = 'someoneelse@elsewhere.com'
          @mailbox.validate
          assert_equal @mailbox.display_name, @mailbox.parsed_address.display_name
          assert_equal @mailbox.address, @mailbox.parsed_address.address
        end

        test 'valid inbound email can be created' do
          assert Mailbox.create(display_name: @mailbox.display_name,
                                address: @mailbox.address.next,
                                followers: @mailbox.followers)
        end

        test 'valid inbound email can be updated' do
          assert @mailbox.update(display_name: @alternate_mailbox.display_name.next,
                                 address: @alternate_mailbox.address.next,
                                 followers: @alternate_mailbox.followers)
        end

        test 'inbound email can be destroyed' do
          assert @mailbox.destroy
        end
      end
    end
  end
end
