# frozen_string_literal: true

require 'test_helper'

module Spina
  module Admin
    module Mail
      class Test < ActiveSupport::TestCase
        test 'RubyGems version is same as Yarn version' do
          path = Pathname.new(File.expand_path('../../../package.json', __dir__))
          assert_equal VERSION, ::ActiveSupport::JSON.decode(path.read)['version']
        end
      end
    end
  end
end
