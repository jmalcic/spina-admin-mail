# frozen_string_literal: true

module Spina
  module Admin
    module Mail
      # This type maps between Mail::Address and string in PostgreSQL
      class EmailAddressType < ActiveRecord::Type::Value
        def cast(value)
          case value
          when ::Mail::Address
            value
          when ::String
            ::Mail::Address.new(value)
          else
            super
          end
        rescue ::Mail::Field::IncompleteParseError
          nil
        end

        def serialize(value)
          case value
          when ::Mail::Address
            value.to_s
          else
            super
          end
        end
      end
    end
  end
end
