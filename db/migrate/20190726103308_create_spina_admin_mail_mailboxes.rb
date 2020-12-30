# frozen_string_literal: true

class CreateSpinaAdminMailMailboxes < ActiveRecord::Migration[6.0] #:nodoc:
  def change
    create_table :spina_admin_mail_mailboxes do |t|
      t.string :address, null: false
      t.string :display_name, null: false

      t.timestamps
    end
  end
end
