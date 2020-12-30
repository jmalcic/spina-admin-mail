# frozen_string_literal: true

require 'active_support/concern'

module Spina
  module Admin
    module Mail
      module EmailTestable
        extend ActiveSupport::Concern

        included do
          test 'belongs to thread' do
            assert @email.thread.present?
          end

          test 'has many mailboxes' do
            assert @email.mailboxes.present?
          end

          test 'has many thread predecessors' do
            assert @email.thread_predecessors.present?
          end

          test 'has many thread successors' do
            assert @email.thread_successors.present?
          end

          test 'has rich text message' do
            assert @email.message.present?
          end

          test 'email updates nested attributes of thread' do
            assert_changes '@email.thread.mailboxes.to_a' do
              @email.update thread_attributes: { mailboxes: @alternate_email.thread.mailboxes }
            end
          end

          test 'valid email is valid' do
            assert @email.valid?
          end

          test 'email attributes must not be empty' do
            email = Email.new
            assert email.invalid?
            assert_equal [I18n.translate('errors.messages.blank')], email.errors[:to_addresses]
            assert_equal [I18n.translate('errors.messages.blank')], email.errors[:subject]
            assert_equal [I18n.translate('errors.messages.blank')], email.errors[:message]
          end

          test 'email must have unique message ID' do
            @email.message_id = @alternate_email.message_id
            assert @email.invalid?
            assert_equal [I18n.translate('errors.messages.taken')], @email.errors[:message_id]
            @email.message_id = spina_admin_mail_outbound_emails(:placeholder_text_outbound).message_id
            assert @email.invalid?
            assert_equal [I18n.translate('errors.messages.taken')], @email.errors[:message_id]
          end

          test 'email destroys orphaned thread on destruction' do
            assert_called(Thread, :destroy_orphans) { @email.destroy }
          end
        end
      end
    end
  end
end
