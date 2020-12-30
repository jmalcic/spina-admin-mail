# frozen_string_literal: true

require 'test_helper'

require 'models/concerns/spina/admin/mail/email_testable'

module Spina
  module Admin
    module Mail
      class EmailTest < ActiveSupport::TestCase
        include EmailTestable

        setup do
          @email = spina_admin_mail_emails :placeholder_text_draft_2
          @alternate_email = spina_admin_mail_emails :new_book_draft
        end

        test 'email returns list of correspondents' do
          assert_equal @email.correspondents, []
        end

        test 'valid email can be created' do
          assert Email.create(from_addresses: @email.from_addresses,
                              to_addresses: @email.to_addresses,
                              subject: @email.subject,
                              date: @email.date,
                              read: @email.read,
                              thread: @email.thread,
                              message_id: @email.message_id.next,
                              message: @email.message)
        end

        test 'valid email can be updated' do
          assert @email.update(from_addresses: @alternate_email.from_addresses,
                               to_addresses: @alternate_email.to_addresses,
                               subject: @alternate_email.subject,
                               date: @alternate_email.date,
                               read: @alternate_email.read,
                               thread: @alternate_email.thread,
                               message_id: @alternate_email.message_id.next,
                               message: @alternate_email.message)
        end

        test 'email can be destroyed' do
          assert @email.destroy
        end
      end
    end
  end
end
