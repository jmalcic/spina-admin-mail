# frozen_string_literal: true

require 'test_helper'

require 'models/concerns/spina/admin/mail/email_testable'

module Spina
  module Admin
    module Mail
      class OutboundEmailTest < ActiveSupport::TestCase
        include EmailTestable
        include ActionMailer::TestHelper

        setup do
          @outbound_email = spina_admin_mail_outbound_emails :placeholder_text_outbound
          @alternate_outbound_email = spina_admin_mail_outbound_emails :new_book_outbound
          @email = @outbound_email
          @alternate_email = @alternate_outbound_email
        end

        test 'belongs to quoted email' do
          assert @outbound_email.quoted_email.present?
        end

        test 'valid outbound email is valid' do
          assert @outbound_email.valid?
        end

        test 'message must not be empty on update' do
          @outbound_email.message_id = nil
          assert @outbound_email.invalid?
          assert_equal [I18n.translate('errors.messages.blank')], @outbound_email.errors[:message_id]
        end

        test 'outbound email initializes thread after initialization' do
          assert_instance_of Thread, OutboundEmail.new.thread
        end

        test 'outbound email sends email after creation' do
          assert_called_on_instance_of ::ActionMailer::MessageDelivery, :deliver_later do
            OutboundEmail.create(to_addresses: @outbound_email.to_addresses,
                                 subject: @outbound_email.subject,
                                 date: @outbound_email.date,
                                 thread: @outbound_email.thread,
                                 quoted_email: @outbound_email.quoted_email,
                                 message_id: @outbound_email.message_id.next,
                                 message: @outbound_email.message)
          end
        end

        test 'outbound email returns list of correspondents' do
          assert_equal @outbound_email.correspondents, @outbound_email.to_addresses
        end

        test 'valid outbound email can be created' do
          assert OutboundEmail.create(to_addresses: @outbound_email.to_addresses,
                                      subject: @outbound_email.subject,
                                      date: @outbound_email.date,
                                      thread: @outbound_email.thread,
                                      quoted_email: @outbound_email.quoted_email,
                                      message_id: @outbound_email.message_id.next,
                                      message: @outbound_email.message)
        end

        test 'valid outbound email can be updated' do
          assert @outbound_email.update(to_addresses: @alternate_outbound_email.to_addresses,
                                        subject: @alternate_outbound_email.subject,
                                        date: @alternate_outbound_email.date,
                                        thread: @alternate_outbound_email.thread,
                                        quoted_email: @alternate_outbound_email.quoted_email,
                                        message_id: @alternate_outbound_email.message_id.next,
                                        message: @alternate_outbound_email.message)
        end

        test 'outbound email can be destroyed' do
          assert @outbound_email.destroy
        end
      end
    end
  end
end
