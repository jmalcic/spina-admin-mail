# frozen_string_literal: true

class CreateJoinTableSpinaAdminMailUserMailbox < ActiveRecord::Migration[6.0] #:nodoc:
  def change
    create_join_table :spina_users, :spina_admin_mail_mailboxes do |t|
      t.index %i[spina_user_id spina_admin_mail_mailbox_id],
              name: 'index_spina_users_mail_mailboxes_on_user_and_mailbox_ids'
      t.index %i[spina_admin_mail_mailbox_id spina_user_id],
              name: 'index_spina_users_mail_mailboxes_on_mailbox_and_user_ids'
    end
  end
end
