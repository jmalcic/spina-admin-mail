# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # Base mailer from which other mailers inherit
      class ApplicationMailer < ActionMailer::Base
        default from: 'from@example.com'
        layout 'spina/admin/mail/mailer'
      end
    end
  end
end
