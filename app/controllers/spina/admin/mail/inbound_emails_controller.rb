# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # This class manages emails and sets breadcrumbs
      class InboundEmailsController < AdminController
        before_action :set_breadcrumbs

        def index
          @inbound_emails = InboundEmail.all
        end

        def edit
          @inbound_email = InboundEmail.find params[:id]
          add_breadcrumb @inbound_email.subject
          render layout: 'spina/admin/admin'
        end

        def show
          @inbound_email = InboundEmail.find params[:id]
          @inbound_email.update(read: true)
          add_breadcrumb @inbound_email.subject
        end

        def update
          @inbound_email = InboundEmail.find params[:id]
          set_update_breadcrumb
          if @inbound_email.update(inbound_email_params)
            redirect_to admin_mail_inbound_emails_path
          else
            render :edit, layout: 'spina/admin/admin'
          end
        end

        def destroy
          @inbound_email = InboundEmail.find params[:id]
          @inbound_email.destroy
          redirect_to admin_mail_inbound_emails_path
        end

        private

        def set_breadcrumbs
          add_breadcrumb I18n.t('spina.admin.mail.website.inbound_emails'), admin_mail_inbound_emails_path
        end

        def set_update_breadcrumb
          return unless @inbound_email.present?

          add_breadcrumb @inbound_email.subject
        end

        def inbound_email_params
          params.require(:admin_mail_inbound_email).permit(:read, thread_attributes: [mailbox_ids: []])
        end
      end
    end
  end
end
