# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Mail
      class BounceMailerTest < ActionMailer::TestCase
        test 'unknown recipient' do
          inbound_email = ::MiniTest::Mock.new
          inbound_email.expect :mail, ::Mail.new(file_fixture('vesuvius.eml').read)
          mail = BounceMailer.with(email: inbound_email).unknown_recipient('Joe Bloggs <nobody@elsewhere.com>')
          assert_equal 'Let\'s talk about Vesuvius', mail.subject
          assert_equal ['nobody@elsewhere.com'], mail.to
          assert_equal ['j.malcic@me.com'], mail.from
          assert_match 'The following recipients you sent this message to do not exist:', mail.text_part.body.decoded
          assert_match 'Joe Bloggs <nobody@elsewhere.com>', mail.text_part.body.decoded
          assert_match 'Check the address(es) you entered again.', mail.text_part.body.decoded
          assert_match 'If you think you have received this message in error, contact the website maintainer.',
                       mail.text_part.body.decoded
          assert_match 'In the original message, you wrote:', mail.text_part.body.decoded
          assert_match 'Look at this picture of Vesuvius!', mail.text_part.body.decoded
          if mail.attachments.any?
            assert_match 'Additionally, you attached 1 file(s), also attached to this message:',
                         mail.text_part.body.decoded
            assert_match mail.attachments.first.filename, mail.text_part.body.decoded
          end
          assert_match 'The following recipients you sent this message to do not exist:', mail.html_part.body.decoded
          assert_match 'Joe Bloggs <nobody@elsewhere.com>', mail.html_part.body.decoded
          assert_match 'Check the address(es) you entered again.', mail.html_part.body.decoded
          assert_match 'If you think you have received this message in error, contact the website maintainer.',
                       mail.html_part.body.decoded
          assert_match 'In the original message, you wrote:', mail.html_part.body.decoded
          assert_match 'Look at this picture of Vesuvius!', mail.html_part.body.decoded
          if mail.attachments.any?
            assert_match 'Additionally, you attached 1 file(s), also attached to this message:',
                         mail.html_part.body.decoded
            assert_match mail.attachments.first.filename, mail.html_part.body.decoded
          end
        end
      end
    end
  end
end
