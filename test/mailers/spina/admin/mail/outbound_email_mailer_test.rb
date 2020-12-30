# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Mail
      class OutboundEmailMailerTest < ActionMailer::TestCase
        test 'unknown recipient' do
          outbound_email = spina_admin_mail_outbound_emails :new_book_outbound
          mail = OutboundEmailMailer.with(outbound_email: outbound_email).outbound_email
          assert_emails(1) { mail.deliver_now }
          assert_equal 'Re: Liber meus novus: De finibus bonorum et malorum', mail.subject
          assert_equal ['cicero@senatus.roma.ir'], mail.to
          assert_equal ['brutus@senatus.roma.ir'], mail.from
          assert_match action_text_rich_texts(:de_finibus_response).body.to_plain_text, mail.text_part.body.decoded
          assert_match 'On 25 December, -0045 09:00, cicero@senatus.roma.ir wrote:', mail.text_part.body.decoded
          # The plaintext body needs to be squished as the quoted email is indented
          assert_match action_text_rich_texts(:de_finibus).body.to_plain_text, mail.text_part.body.decoded.squish
          assert_match action_text_rich_texts(:de_finibus_response).body.to_html, mail.html_part.body.decoded
          assert_match 'On 25 December, -0045 09:00, cicero@senatus.roma.ir wrote:', mail.html_part.body.decoded
          assert_match action_text_rich_texts(:de_finibus).body.to_html, mail.html_part.body.decoded
        end
      end
    end
  end
end
