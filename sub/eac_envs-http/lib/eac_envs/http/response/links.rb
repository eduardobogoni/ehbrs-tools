# frozen_string_literal: true

module EacEnvs
  module Http
    class Response < ::StandardError
      module Links
        # https://www.w3.org/wiki/LinkHeader
        LINKS_HEADER_NAME = 'Link'

        # https://www.w3.org/wiki/LinkHeader
        LINK_PARSER = /\A<(.+)>\s*;\s*rel\s*=\s*"(.*)"\z/.to_parser do |m|
          [m[2], m[1]]
        end

        def link(rel)
          hash_search(links, rel)
        end

        def links
          header(LINKS_HEADER_NAME).if_present({}) do |v|
            v.split(',').to_h { |w| LINK_PARSER.parse!(w.strip) }
          end
        end
      end
    end
  end
end
