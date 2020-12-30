# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Mail
      class MailboxesControllerTest < ActionDispatch::IntegrationTest
        include ::Spina::Engine.routes.url_helpers

        setup do
          @mailbox = spina_admin_mail_mailboxes :unimark_mailbox
          @alternate_mailbox = spina_admin_mail_mailboxes :senate_mailbox
          @invalid_mailbox = Mailbox.new
          post admin_sessions_url, params: { email: spina_users(:joe).email, password: 'password' }
        end

        test 'should get index' do
          get admin_mail_mailboxes_url
          assert_response :success
        end

        test 'should get new' do
          get new_admin_mail_mailbox_url
          assert_response :success
        end

        test 'should get edit' do
          get edit_admin_mail_mailbox_url(@mailbox)
          assert_response :success
        end

        test 'should show mailbox' do
          get admin_mail_mailbox_url(@mailbox)
          assert_response :success
        end

        test 'should create mailbox' do
          post admin_mail_mailboxes_url,
               params: { admin_mail_mailbox: { display_name: @mailbox.display_name.next,
                                    address: @mailbox.address.next,
                                    followers: @mailbox.followers } }
          assert_redirected_to admin_mail_mailboxes_url
        end

        test 'should fail to create mailbox' do
          post admin_mail_mailboxes_url,
               params: { admin_mail_mailbox: { display_name: @mailbox.display_name,
                                               address: @mailbox.address,
                                               followers: @mailbox.followers } }
          assert_response :success
        end

        test 'should update mailbox' do
          patch admin_mail_mailbox_url(@mailbox),
                params: { admin_mail_mailbox: { display_name: @mailbox.display_name,
                                                address: @mailbox.address,
                                                followers: @mailbox.followers } }
          assert_redirected_to admin_mail_mailboxes_url
        end

        test 'should fail to update mailbox' do
          patch admin_mail_mailbox_url(@mailbox),
                params: { admin_mail_mailbox: { address: @alternate_mailbox.address } }
          assert_response :success
        end

        test 'should destroy mailbox' do
          delete admin_mail_mailbox_url(@mailbox)
          assert_redirected_to admin_mail_mailboxes_url
        end
      end
    end
  end
end
