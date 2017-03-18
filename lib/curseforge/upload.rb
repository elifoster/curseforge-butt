require 'mime/types'

module CurseForge
  module Upload
    def upload(file, changelog, release_type, versions, opts = {})
      ext = file.split('.')[-1]
      mimetype = MIME::Types.type_for(ext)
      display = opts[:display_name] || file
      markup = validate_markup(opts[:markup_type])
      metadata = {
        :changelog => changelog,
        :releaseType => release_type,
        :gameVersions => versions,
        :displayName => display,
        :change_markup_type => markup
      }

      url = "https://#{@game}.curseforge.com/api/projects/#{@projectid}/upload-file"
      header = {
        'metadata' => metadata,
        'file' => UploadIO.new(File.new(file), mimetype)
      }

      post(url, header)
    end

    private

    # @return [Array<String>] As specified in the API documentation.
    VALID_TYPES = %w(text html markdown)

    def validate_markup(markup_type)
      return 'text' unless markup_type
      markup_type.downcase!
      return markup_type if VALID_TYPES.include?(markup_type)
      'text'
    end
  end
end
