# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Mail
      class InboundEmailsControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup do
          @inbound_email = spina_admin_mail_inbound_emails :placeholder_text_inbound
          @alternate_inbound_email = spina_admin_mail_inbound_emails :new_book_inbound
          @invalid_inbound_email = InboundEmail.new
          post admin_sessions_url, params: { email: spina_users(:joe).email, password: 'password' }
        end

        test 'should get index' do
          get admin_mail_inbound_emails_url
          assert_response :success
        end

        test 'should get edit' do
          get edit_admin_mail_inbound_email_url(@inbound_email)
          assert_response :success
        end

        test 'should show inbound email' do
          get admin_mail_inbound_email_url(@inbound_email)
          assert_response :success
        end

        test 'should update inbound email' do
          patch admin_mail_inbound_email_url(@inbound_email), params: { admin_mail_inbound_email: { read: @inbound_email.read } }
          assert_redirected_to admin_mail_inbound_emails_url
        end

        test 'should fail to update inbound email' do
          patch admin_mail_inbound_email_url(@inbound_email),
                params: { admin_mail_inbound_email: { thread_attributes: { mailbox_ids: [] } } }
          assert_response :success
        end

        test 'should destroy inbound email' do
          assert_difference('InboundEmail.count', -1) { delete admin_mail_inbound_email_url(@inbound_email) }
          assert_redirected_to admin_mail_inbound_emails_url
        end
      end
    end
  end
end
