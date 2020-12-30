# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Mail
      class NotificationMailerTest < ActionMailer::TestCase
        include ::Spina::Engine.routes.url_helpers

        test 'inbound email' do
          inbound_email = spina_admin_mail_inbound_emails :placeholder_text_inbound
          mailbox = inbound_email.mailboxes.first
          mail = NotificationMailer.inbound_email(inbound_email, mailbox)
          assert_equal 'Fw: Some placeholder text', mail.subject
          assert_equal ['someone@someaddress.com'], mail.to
          assert_equal ['someone@unimark.com'], mail.from
          assert_match 'On 25 August, 1963 15:00, someone@letraset.com wrote:', mail.text_part.body.decoded
          assert_match inbound_email.message.body.to_plain_text, mail.text_part.body.decoded.squish
          assert_match "You have received this message because you follow the mailbox it was sent to (#{mailbox.display_name}).",
                       mail.text_part.body.decoded
          assert_match "Unfollow this mailbox at #{admin_mail_mailbox_url(mailbox, host: 'test')}.",
                       mail.text_part.body.decoded
          assert_match 'On 25 August, 1963 15:00, someone@letraset.com wrote:', mail.html_part.body.decoded
          assert_match inbound_email.message.body.to_html, mail.html_part.body.decoded
          assert_match "You have received this message because you follow the mailbox it was sent to (#{mailbox.display_name}).",
                       mail.html_part.body.decoded
          assert_match %(<a href="#{admin_mail_mailbox_url(mailbox, host: 'test')}">Unfollow this mailbox</a>),
                       mail.html_part.body.decoded
        end
      end
    end
  end
end
