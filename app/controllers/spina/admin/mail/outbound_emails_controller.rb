# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # This class manages emails and sets breadcrumbs
      class OutboundEmailsController < AdminController
        before_action :set_breadcrumbs

        def index
          @outbound_emails = OutboundEmail.all
        end

        def new
          @outbound_email = if params[:quoted_email]
                              OutboundEmail.new(quoted_email_params)
                            else
                              OutboundEmail.new
                            end
          add_breadcrumb I18n.t('spina.admin.mail.outbound_emails.new')
          render layout: 'spina/admin/admin'
        end

        def edit
          @outbound_email = OutboundEmail.find params[:id]
          add_breadcrumb @outbound_email.subject
          render layout: 'spina/admin/admin'
        end

        def show
          @outbound_email = OutboundEmail.find params[:id]
          add_breadcrumb @outbound_email.subject
        end

        def create
          @outbound_email = OutboundEmail.new(outbound_email_params)
          add_breadcrumb I18n.t('spina.admin.mail.outbound_emails.new')
          if @outbound_email.save
            redirect_to admin_mail_outbound_emails_path
          else
            render :new, layout: 'spina/admin/admin'
          end
        end

        def update
          @outbound_email = OutboundEmail.find params[:id]
          set_update_breadcrumb
          if @outbound_email.update(outbound_email_params.except(:to_addresses, :cc_addresses, :bcc_addresses, :subject,
                                                                 :message))
            redirect_to admin_mail_outbound_emails_path
          else
            render :edit, layout: 'spina/admin/admin'
          end
        end

        def destroy
          @outbound_email = OutboundEmail.find params[:id]
          @outbound_email.destroy
          redirect_to admin_mail_outbound_emails_path
        end

        private

        def set_breadcrumbs
          add_breadcrumb I18n.t('spina.admin.mail.website.outbound_emails'), admin_mail_outbound_emails_path
        end

        def set_update_breadcrumb
          return unless @outbound_email.present?

          add_breadcrumb @outbound_email.subject
        end

        def outbound_email_params
          params.require(:admin_mail_outbound_email).permit(:subject, :message, :thread_id, :quoted_email_id,
                                                            to_addresses: [], cc_addresses: [], bcc_addresses: [],
                                                            thread_attributes: [mailbox_ids: []])
        end

        def quoted_email_params
          email = Email.find params[:quoted_email][:id]
          {
            subject: "Re: #{email.subject}",
            thread: email.thread,
            to_addresses: email.from_addresses,
            cc_addresses: email.cc_addresses,
            bcc_addresses: email.bcc_addresses,
            quoted_email: email
          }
        end
      end
    end
  end
end
