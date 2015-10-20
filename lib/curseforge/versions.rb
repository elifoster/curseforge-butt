module CurseForge
  module Versions
    # Gets the valid versions for the game.
    # @return [Hash] A hash containing ID => Name pairs.
    def get_versions
      url = "https://#{@game}.curseforge.com/api/game/versions"
      response = get(url, true, 'X-Api-Token' => @api_key)

      ret = {}
      response.each do |i|
        ret[i['id']] = i['name']
      end

      ret
    end

    # Gets the version name by the given ID.
    # @param id [Int] The ID for the name.
    # @param hash [Hash] The hash containing all of the versions.
    def get_name_from_id(id, hash = nil)
      hash = get_versions if hash.nil?
      hash.values_at(id)
    end

    # Gets the version ID by the given name.
    # @param name [String] The name for the ID.
    # @param hash [Hash] The hash containing all of the versions.
    def get_id_from_name(name, hash = nil)
      hash = get_versions if hash.nil?
      hash.key(name)
    end
  end
end
