# frozen_string_literal: true

require 'test_helper'

require 'models/concerns/spina/admin/mail/email_testable'

module Spina
  module Admin
    module Mail
      class InboundEmailTest < ActiveSupport::TestCase
        include EmailTestable

        setup do
          @inbound_email = spina_admin_mail_inbound_emails :placeholder_text_inbound
          @alternate_inbound_email = spina_admin_mail_inbound_emails :new_book_inbound
          @email = @inbound_email
          @alternate_email = @alternate_inbound_email
        end

        test 'valid inbound email is valid' do
          assert @inbound_email.valid?
        end

        test 'inbound email attributes must not be empty' do
          inbound_email = InboundEmail.new
          assert inbound_email.invalid?
          assert_equal [I18n.translate('errors.messages.blank')], inbound_email.errors[:from_addresses]
          assert_equal [I18n.translate('errors.messages.blank')], inbound_email.errors[:message_id]
          assert_equal [I18n.translate('errors.messages.blank')], inbound_email.errors[:thread_id]
        end

        test 'new inbound email must not be read' do
          inbound_email = InboundEmail.new(from_addresses: @inbound_email.from_addresses,
                                           to_addresses: @inbound_email.to_addresses,
                                           subject: @inbound_email.subject,
                                           date: @inbound_email.date,
                                           read: true,
                                           thread: @inbound_email.thread,
                                           message_id: @inbound_email.message_id.next,
                                           message: @inbound_email.message)
          assert inbound_email.invalid?
          assert_equal [I18n.translate('errors.messages.present')], inbound_email.errors[:read]
        end

        test 'inbound email sends email after creation' do
          assert_called_on_instance_of ::ActionMailer::MessageDelivery, :deliver_later, times: 1 do
            InboundEmail.create(from_addresses: @inbound_email.from_addresses,
                                to_addresses: @inbound_email.to_addresses,
                                subject: @inbound_email.subject,
                                date: @inbound_email.date,
                                read: @inbound_email.read,
                                thread: @inbound_email.thread,
                                message_id: @inbound_email.message_id.next,
                                message: @inbound_email.message)
          end
        end

        test 'inbound email returns list of correspondents' do
          assert_equal @inbound_email.correspondents, @inbound_email.from_addresses
        end

        test 'valid inbound email can be created' do
          assert InboundEmail.create(from_addresses: @inbound_email.from_addresses,
                                     to_addresses: @inbound_email.to_addresses,
                                     subject: @inbound_email.subject,
                                     date: @inbound_email.date,
                                     read: @inbound_email.read,
                                     thread: @inbound_email.thread,
                                     message_id: @inbound_email.message_id.next,
                                     message: @inbound_email.message)
        end

        test 'valid inbound email can be updated' do
          assert @inbound_email.update(from_addresses: @alternate_inbound_email.from_addresses,
                                       to_addresses: @alternate_inbound_email.to_addresses,
                                       subject: @alternate_inbound_email.subject,
                                       date: @alternate_inbound_email.date,
                                       read: @alternate_inbound_email.read,
                                       thread: @alternate_inbound_email.thread,
                                       message_id: @alternate_inbound_email.message_id.next,
                                       message: @alternate_inbound_email.message)
        end

        test 'inbound email can be destroyed' do
          assert @inbound_email.destroy
        end
      end
    end
  end
end
