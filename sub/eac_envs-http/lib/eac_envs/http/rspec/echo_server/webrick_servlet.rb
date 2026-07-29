# frozen_string_literal: true

require 'webrick'

module EacEnvs
  module Http
    module Rspec
      class EchoServer
        class WebrickServlet < WEBrick::HTTPServlet::AbstractServlet
          ::EacEnvs::Http::Request.lists.verb.each_value do |verb|
            define_method "do_#{verb.to_s.upcase}" do |request, response|
              ::EacEnvs::Http::Rspec::EchoServer::RequestProcessor.new(request, response).perform
            end
          end
        end
      end
    end
  end
end
