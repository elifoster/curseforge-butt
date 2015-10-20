require_relative 'versions'
require_relative 'upload'
require 'httpclient'
require 'json'

module CurseForge
  class Butt
    include CurseForge::Versions
    include CurseForge::Upload

    # Creates a new CurseForge::Butt instance.
    # @param projectid [String/Int] The ID for the project.
    # @param game [String] The game to use.
    # @param api_key [String] The user's API key which will be used to access
    #   everything.
    def initialize(projectid, game, api_key)
      @projectid =
        if projectid.is_a?(Fixnum)
          projectid.to_s
        else
          projectid
        end
      @game = game
      @api_key = api_key

      @client = HTTPClient.new
    end

    # Performs a generic GET request with the provided URL.
    # @param url [String] The URL to get.
    # @param autoparse [Boolean] Whether to return a parsed JSON or a raw
    #   HTTPMessage response.
    # @param header [Hash] The header hash.
    # @return [HTTPMessage/JSON] A parsed JSON or raw HTTPMessage, depending on
    #   the value of autoparse.
    def get(url, autoparse = true, header = nil)
      uri = URI.parse(url)
      header = {} if header.nil?

      response = @client.get(uri, header)
      if autoparse
        return JSON.parse(response.body)
      else
        return response
      end
    end

    # Performs a generic POSt request with the provided URL.
    # @param url [String] See #get
    # @param autoparse [Boolean] See #get
    # @param header [Hash] See #get
    # @return [HTTPMessage/JSON] See #get
    def post(url, autoparse = true, header = nil)
      uri = URI.parse(url)
      header = {} if header.nil?

      response = @client.post(uri, header)
      if autoparse
        return JSON.parse(response.body)
      else
        return response
      end
    end
  end
end
