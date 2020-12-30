# frozen_string_literal: true

class CreateSpinaAdminMailEmails < ActiveRecord::Migration[6.0] #:nodoc:
  def change
    create_table :spina_admin_mail_emails do |t|
      t.string :type
      t.string :from_addresses, array: true
      t.string :to_addresses, null: false, array: true, default: []
      t.string :cc_addresses, null: false, array: true, default: []
      t.string :bcc_addresses, null: false, array: true, default: []
      t.string :reply_to, null: false, array: true, default: []
      t.string :subject, null: false
      t.string :message_id
      t.integer :priority
      t.datetime :date, null: false
      t.boolean :read, default: false
      t.references :thread, null: false, foreign_key: { to_table: 'spina_admin_mail_threads', on_delete: :cascade }
      t.references :quoted_email, foreign_key: { to_table: 'spina_admin_mail_emails', on_delete: :nullify }
    end
  end
end
