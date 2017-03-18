require_relative 'versions'
require_relative 'upload'
require 'httpclient'
require 'oj'

module CurseForge
  class Butt
    include CurseForge::Versions
    include CurseForge::Upload

    # Creates a new CurseForge::Butt instance.
    # @param projectid [String/Integer] The ID for the project.
    # @param game [String] The game to use.
    # @param api_key [String] The user's API key which will be used to access everything.
    def initialize(projectid, game, api_key)
      @projectid = projectid.is_a?(Integer) ? projectid.to_s : projectid
      @game = game
      @api_key = api_key

      @client = HTTPClient.new
    end

    # Performs a generic GET request with the provided URL.
    # @param url [String] The URL to get.
    # @param header [Hash] The header hash. Automatically assigns the X-Api-Token key to the api key.
    # @return [Object] The response as a parsed JSON object
    # @raise [CurseForge::Butt::Error] A CurseForge error object whose message is the code and the message returned by
    #   the API if it failed.
    def get(url, header = nil)
      uri = URI.parse(url)
      header = {} if header.nil?
      header['X-Api-Token'] = @api_key

      ret = Oj.load(@client.get(uri, {}, header).body)
      fail Error.new(ret) if ret.is_a?(Hash) && ret['errorCode']
      ret
    end

    # Performs a generic POST request with the provided URL.
    # @param url [String] See #get
    # @param header [Hash] See #get
    # @return [Object] See #get
    # @raise [CurseForge::Butt::Error] See #get
    def post(url, header = nil)
      uri = URI.parse(url)
      header = {} if header.nil?
      header['X-Api-Token'] = @api_key

      ret = Oj.load(@client.post(uri, {}, header).body)
      fail Error.new(ret) if ret.is_a?(Hash) && ret['errorCode']
      ret
    end

    class Error < StandardError
      def initialize(opts = {})
        @code = opts['errorCode']
        @msg = opts['errorMessage']
      end

      def message
        "#{@code}: #{@msg}"
      end
    end
  end
end
