# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Session < ::SimpleDelegator
      module User
        # @return [Boolean]
        def logged?
          navigate.to(build_url('/player'))
          logged_username == username
        end

        # @return [String]
        def logged_username
          find_or_not_element(xpath: '//*[@id = "connected_username"]').attribute('innerHTML').strip
        end

        def on_logged(&block)
          unless logged?
            raise "Login failed for BoardGameUser user \"#{username}\"" unless login
          end

          block.call
        end
      end
    end
  end
end
