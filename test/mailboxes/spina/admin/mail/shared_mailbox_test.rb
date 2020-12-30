# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Mail
      class SharedMailboxTest < ActionMailbox::TestCase
        include ::ActionMailer::TestHelper

        test 'receive mail from known sender' do
          assert_emails 1 do
            receive_inbound_email_from_mail to: '"Some One" <someone@unimark.com>', from: '"Bill" <bill@example.com>',
                                            subject: 'Hello world!', body: 'Hello?'
          end
        end

        test 'receive mail from unknown sender' do
          assert_emails 1 do
            receive_inbound_email_from_mail to: '"No One" <noone@nowhere.com>', from: '"Nobody" <nobody@elsewhere.com>',
                                            subject: 'Hello world!', body: 'Hello?'
          end
        end
      end
    end
  end
end
