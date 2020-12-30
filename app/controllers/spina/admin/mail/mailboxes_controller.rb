# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # This class manages emails and sets breadcrumbs
      class MailboxesController < AdminController
        before_action :set_breadcrumbs

        def index
          @mailboxes = Mailbox.all
        end

        def new
          @mailbox = Mailbox.new
          add_breadcrumb I18n.t('spina.admin.mail.mailboxes.new')
          render layout: 'spina/admin/admin'
        end

        def edit
          @mailbox = Mailbox.find params[:id]
          add_breadcrumb @mailbox.display_name
          render layout: 'spina/admin/admin'
        end

        def show
          @mailbox = Mailbox.find params[:id]
          add_breadcrumb @mailbox.display_name
        end

        def create
          @mailbox = Mailbox.new(mailbox_params)
          add_breadcrumb I18n.t('spina.admin.mail.mailboxes.new')
          if @mailbox.save
            redirect_to admin_mail_mailboxes_path
          else
            render :new, layout: 'spina/admin/admin'
          end
        end

        def update
          @mailbox = Mailbox.find params[:id]
          set_update_breadcrumb
          if @mailbox.update(mailbox_params)
            redirect_to admin_mail_mailboxes_path
          else
            render :edit, layout: 'spina/admin/admin'
          end
        end

        def destroy
          @mailbox = Mailbox.find params[:id]
          @mailbox.destroy
          redirect_to admin_mail_mailboxes_path
        end

        private

        def set_breadcrumbs
          add_breadcrumb I18n.t('spina.admin.mail.website.mailboxes'), admin_mail_mailboxes_path
        end

        def set_update_breadcrumb
          return unless @mailbox.present?

          add_breadcrumb @mailbox.display_name
        end

        def mailbox_params
          params.require(:admin_mail_mailbox).permit(:display_name, :address, follower_ids: [], threads_attributes: {})
        end
      end
    end
  end
end
