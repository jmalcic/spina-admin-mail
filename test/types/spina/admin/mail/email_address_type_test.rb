# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Mail
      class EmailAddressTypeTest < ActiveSupport::TestCase
        setup { @email_address_type = EmailAddressType.new }

        test 'type casts mail address' do
          address = ::Mail::Address.new('someone@example.com')
          assert_equal @email_address_type.cast(address), address
        end

        test 'type casts string' do
          string = 'someone@example.com'
          assert_equal @email_address_type.cast(string), ::Mail::Address.new(string)
        end

        test 'type delegates casting as fallback' do
          assert_called_on_instance_of ::ActiveRecord::Type::Value, :cast do
            @email_address_type.cast(1)
          end
        end

        test 'type handles incomplete parse error' do
          assert_nil @email_address_type.cast('.')
        end

        test 'type serializes mail address' do
          address = ::Mail::Address.new('someone@example.com')
          assert_equal @email_address_type.serialize(address), address.to_s
        end

        test 'type delegates serialization as fallback' do
          assert_called_on_instance_of ::ActiveRecord::Type::Value, :serialize do
            @email_address_type.serialize(1)
          end
        end
      end
    end
  end
end
