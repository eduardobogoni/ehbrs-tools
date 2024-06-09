# frozen_string_literal: true

require 'ehbrs_ruby_utils/videos2/unsupported/checks'

module EhbrsRubyUtils
  module Videos2
    module Unsupported
      class CheckSet
        enable_simple_cache
        common_constructor :checks

        class << self
          # type: "file" or "track"
          def build(profiles, type)
            r = {}
            profiles.each do |profile|
              profile.send("#{type}_checks").each do |check|
                r[check] ||= CheckWithProfiles.new(check)
                r[check].add_profile(profile)
              end
            end
            new(r.values)
          end
        end

        class CheckWithProfiles < ::SimpleDelegator
          def initialize(check)
            super
            @profiles = []
          end

          def check_name
            __getobj__.class.name.demodulize
          end

          def add_profile(profile)
            @profiles << profile
          end
        end
      end
    end
  end
end
