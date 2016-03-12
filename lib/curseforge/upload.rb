require 'mime/types'

module CurseForge
  module Upload
    def upload(file, changelog, release_type, versions, display, markup)
      ext = file.split('.')[-1]
      mimetype = MIME::Types.type_for(ext)
      metadata = {
        :changelog => changelog,
        :releaseType => release_type,
        :gameVersions => versions,
        :displayname => file,
        :change_markup_type => markup
      }

      url = "https://#{@game}.curseforge.com/api/projects/#{@projectid}/upload-file"
      header = {
        'X-Api-Token' => @api_key,
        'metadata' => metadata,
        'file' => UploadIO.new(File.new(file), mimetype)
      }

      post(url, true, header)
    end
  end
end
