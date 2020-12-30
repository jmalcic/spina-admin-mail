# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Mail
      class ThreadTest < ActiveSupport::TestCase
        setup do
          @thread = spina_admin_mail_threads :placeholder_text
          @alternate_thread = spina_admin_mail_threads :new_book
          @orphaned_thread = spina_admin_mail_threads :orphan
        end

        test 'orphaned scope returns orphaned threads' do
          assert_includes Thread.orphaned, @orphaned_thread
          refute_includes Thread.orphaned, @thread
        end

        test 'has and belongs to many mailboxes' do
          assert @thread.mailboxes
        end

        test 'has many emails' do
          assert @thread.emails
        end

        test 'valid thread is valid' do
          assert @thread.valid?
        end

        test 'thread attributes must not be empty' do
          thread = Thread.new
          assert thread.invalid?
          assert thread.errors[:mailbox_ids].any?
        end

        test 'thread is destroyed if orphaned' do
          assert_includes Thread.destroy_orphans, @orphaned_thread
        end

        test 'valid thread can be created' do
          assert Thread.create(mailboxes: @thread.mailboxes)
        end

        test 'valid thread can be updated' do
          assert @thread.update(mailboxes: @alternate_thread.mailboxes)
        end

        test 'thread can be destroyed' do
          assert @thread.destroy
        end
      end
    end
  end
end
