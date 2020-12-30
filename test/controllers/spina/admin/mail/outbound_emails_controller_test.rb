# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Mail
      class OutboundEmailControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup do
          @outbound_email = spina_admin_mail_outbound_emails :placeholder_text_outbound
          @alternate_outbound_email = spina_admin_mail_outbound_emails :new_book_outbound
          @invalid_outbound_email = OutboundEmail.new
          post admin_sessions_url, params: { email: spina_users(:joe).email, password: 'password' }
        end

        test 'should get index' do
          get admin_mail_outbound_emails_url
          assert_response :success
        end

        test 'should get new' do
          get new_admin_mail_outbound_email_url
          assert_response :success
        end

        test 'should get new with params' do
          get new_admin_mail_outbound_email_url,
              params: { admin_mail_inbound_email: { id: spina_admin_mail_inbound_emails(:placeholder_text_inbound).id } }
          assert_response :success
        end

        test 'should get edit' do
          get edit_admin_mail_outbound_email_url(@outbound_email)
          assert_response :success
        end

        test 'should show inbound email' do
          get admin_mail_outbound_email_url(@outbound_email)
          assert_response :success
        end

        test 'should create outbound email' do
          assert_emails 1 do
            post admin_mail_outbound_emails_url,
                 params: { admin_mail_outbound_email: { subject: @outbound_email.subject,
                                                        message: @outbound_email.message,
                                                        thread_id: @outbound_email.thread_id,
                                                        quoted_email_id: @outbound_email.quoted_email_id,
                                                        to_addresses: @outbound_email.to_addresses,
                                                        cc_addresses: @outbound_email.cc_addresses,
                                                        bcc_addresses: @outbound_email.bcc_addresses } }
          end
          assert_redirected_to admin_mail_outbound_emails_url
        end

        test 'should fail to create outbound email' do
          post admin_mail_outbound_emails_url,
               params: { admin_mail_outbound_email: { subject: @invalid_outbound_email.subject,
                                                      message: @invalid_outbound_email.message,
                                                      thread_id: @invalid_outbound_email.thread_id,
                                                      quoted_email_id: @invalid_outbound_email.quoted_email_id,
                                                      to_addresses: @invalid_outbound_email.to_addresses,
                                                      cc_addresses: @invalid_outbound_email.cc_addresses,
                                                      bcc_addresses: @invalid_outbound_email.bcc_addresses } }
          assert_response :success
        end

        test 'should update outbound email' do
          patch admin_mail_outbound_email_url(@outbound_email),
                params: { admin_mail_outbound_email: { subject: @outbound_email.subject,
                                                       message: @outbound_email.message,
                                                       thread_id: @outbound_email.thread_id,
                                                       quoted_email_id: @outbound_email.quoted_email_id,
                                                       to_addresses: @outbound_email.to_addresses,
                                                       cc_addresses: @outbound_email.cc_addresses,
                                                       bcc_addresses: @outbound_email.bcc_addresses } }
          assert_redirected_to admin_mail_outbound_emails_url
        end

        test 'should fail to update inbound email' do
          patch admin_mail_outbound_email_url(@outbound_email),
                params: { admin_mail_outbound_email: { subject: @invalid_outbound_email.subject,
                                                       message: @invalid_outbound_email.message,
                                                       thread_id: @invalid_outbound_email.thread_id,
                                                       quoted_email_id: @invalid_outbound_email.quoted_email_id,
                                                       to_addresses: @invalid_outbound_email.to_addresses,
                                                       cc_addresses: @invalid_outbound_email.cc_addresses,
                                                       bcc_addresses: @invalid_outbound_email.bcc_addresses } }
          assert_response :success
        end

        test 'should destroy inbound email' do
          assert_difference('OutboundEmail.count', -1) { delete admin_mail_outbound_email_url(@outbound_email) }
          assert_redirected_to admin_mail_outbound_emails_url
        end
      end
    end
  end
end
