# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # Preview all emails at http://localhost:3000/rails/mailers/spina/admin/mail/bounce_mailer
      class BounceMailerPreview < ActionMailer::Preview
        # Preview this email at http://localhost:3000/rails/mailers/spina/admin/mail/bounce_mailer/unknown_recipient
        def unknown_recipient
          BounceMailer.with(email: InboundEmail.first.mail).unknown_recipient
        end
      end
    end
  end
end
