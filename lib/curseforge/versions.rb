module CurseForge
  module Versions
    # Gets the valid versions for the game.
    # @return [Array<CurseForge::Versions::Version>] Array of Version objects
    def get_versions
      get("https://#{@game}.curseforge.com/api/game/versions").map { |i| Version.new(i) }
    end

    # An object representing a game version.
    class Version
      # @return [Integer]
      attr_reader :id
      # @return [Integer] Not sure what this is, undocumented in the API.
      attr_reader :type
      # @return [String]
      attr_reader :name
      # @return [String]
      attr_reader :slug

      # Creates a new Version. Typically, this will only be done by the Versions module itself.
      # @param opts [Hash] As returned and specified by the API.
      def initialize(opts = {})
        @id = opts[:id]
        @type = opts[:gameVersionTypeID]
        @name = opts[:name]
        @slug = opts[:slug]
      end
    end
  end
end
