# -*- coding: UTF-8 -*-

require "uri"
require "json"
require "open-uri"

require_relative "./defcli/formatting"

module Defcli
  class << self
    def version
      "0.0.1"
    end

    # Format results for output
    # @param results [Array] array of results
    # @param color [Boolean] colored output
    # @return [String]
    def format_results(results, color = true)
      Defcli::Formatting.format_results(results, color)
    end

    def read_url(url)
      OpenURI.open_uri(url).read
    end

    def open_in_browser(url)
      system open_cmd, url
    end

    private

    def open_cmd
      case RbConfig::CONFIG["host_os"]
      when /darwin/
        "open"
      when /bsd|linux/
        "xdg-open"
      when /cygwin|mingw|mswin/
        "start"
      end
    end
  end
end
