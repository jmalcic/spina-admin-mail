# frozen_string_literal: true

# Base class from which mailboxes inherit
class ApplicationMailbox < ActionMailbox::Base
  routing all: :'spina/admin/mail/shared'
end
