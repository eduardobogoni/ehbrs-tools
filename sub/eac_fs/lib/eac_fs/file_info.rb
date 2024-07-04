# frozen_string_literal: true

require 'eac_fs/executables'
require 'eac_ruby_utils/core_ext'
require 'content-type'
require 'filemagic'

module EacFs
  class FileInfo
    UNKNOWN_CONTENT_TYPE_STRING = 'application/octet-stream'
    UNKNOWN_CONTENT_TYPE = ::ContentType.parse(UNKNOWN_CONTENT_TYPE_STRING)

    enable_simple_cache

    # @!attribute [r] path
    #   @return [Pathname]

    # @!method initialize(path)
    #   @param path [Pathname]
    common_constructor :path do
      self.path = path.to_pathname
    end

    delegate :charset, :mime_type, :subtype, :type, to: :content_type

    # @return [Boolean]
    def open?
      ::EacFs::Executables.lsof.command(path).execute.fetch(:exit_code).zero?
    end

    private

    def content_type_uncached
      ::ContentType.parse(magic_string)
    rescue ::Parslet::ParseFailed
      UNKNOWN_CONTENT_TYPE
    end

    # @return [String]
    def magic_string_uncached
      ::FileMagic.new(FileMagic::MAGIC_MIME).file(path.to_path)
    end
  end
end
