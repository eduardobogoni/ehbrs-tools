# frozen_string_literal: true

module Ehbrs
  module Videos
    module Unsupported
      module Profiles
        class Base
          enable_simple_cache
          include ::Singleton

          CONSTANT_PREFIXES = %w[video audio subtitle other].freeze

          def added_checks
            @added_checks ||= []
          end

          def add_check(name, *args)
            check_path = "ehbrs/videos/unsupported/checks/#{name}"
            added_checks << check_path.camelize.constantize.new(*args)
          end

          def file_checks
            added_checks
          end

          def track_checks
            [unlisted_codec_check] + unsupported_codec_checks +
              supported_codecs.flat_map { |codec| codec_extra_checks(codec) }
          end

          def codec_extra_checks(codec)
            codec_unlisted_extra_check(codec).if_present([]) { |v| [v] } +
              codec_unsupported_extras(codec).map do |extra|
                Ehbrs::Videos::Unsupported::Checks::CodecExtraUnsupported.new(codec, extra)
              end
          end

          def codec_unlisted_extra_check(codec)
            extras = codec_unsupported_extras(codec) + codec_supported_extras(codec)
            return nil unless extras.any?

            Ehbrs::Videos::Unsupported::Checks::CodecExtraUnlisted.new(
              codec, extras.sort.uniq
            )
          end

          def name
            self.class.name.demodulize.underscore
          end

          def to_s
            name
          end

          def unsupported_codec_checks
            unsupported_codecs.map do |codec|
              Ehbrs::Videos::Unsupported::Checks::CodecUnsupported.new(codec)
            end
          end

          def unsupported_codecs_uncached
            codecs_by_constant('unsupported')
          end

          def unlisted_codec_check
            ::Ehbrs::Videos::Unsupported::Checks::CodecUnlisted.new(
              (supported_codecs + unsupported_codecs).sort.uniq
            )
          end

          def supported_codecs_uncached
            codecs_by_constant('supported')
          end

          def codecs_by_constant(middle)
            CONSTANT_PREFIXES.inject([]) { |a, e| a + codecs_by_prefix(e, middle) }
          end

          def codecs_by_prefix(prefix, middle)
            self.class.const_get("#{prefix}_#{middle}_codecs".upcase)
          rescue NameError
            []
          end

          def codec_extras(codec, suffix)
            self.class.const_get("#{codec}_extra_#{suffix}".upcase)
          rescue NameError
            []
          end

          def codec_unsupported_extras(codec)
            codec_extras(codec, 'unsupported')
          end

          def codec_supported_extras(codec)
            codec_extras(codec, 'supported')
          end
        end
      end
    end
  end
end