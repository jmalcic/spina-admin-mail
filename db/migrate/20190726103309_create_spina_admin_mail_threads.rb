# frozen_string_literal: true

class CreateSpinaAdminMailThreads < ActiveRecord::Migration[6.0] #:nodoc:
  def change
    create_table :spina_admin_mail_threads, &:timestamps
  end
end
