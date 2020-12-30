# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      class ApplicationRecord < ActiveRecord::Base
        extend Mobility

        self.abstract_class = true
      end
    end
  end
end
