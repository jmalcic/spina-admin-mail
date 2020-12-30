# frozen_string_literal: true

class CreateJoinTableSpinaAdminMailMailboxThread < ActiveRecord::Migration[6.0] #:nodoc:
  def change
    create_join_table :spina_admin_mail_mailboxes, :spina_admin_mail_threads do |t|
      t.index %i[spina_admin_mail_mailbox_id spina_admin_mail_thread_id],
              name: 'index_spina_mail_mailboxes_threads_on_mailbox_and_thread_ids'
      t.index %i[spina_admin_mail_thread_id spina_admin_mail_mailbox_id],
              name: 'index_spina_mail_mailboxes_threads_on_thread_and_mailbox_ids'
    end
  end
end
