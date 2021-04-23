require 'json'

module FileUser

    def fetchJson(filePath)
        file = File.read(filePath)
        jsonHash = JSON.parse(file)

        return jsonHash
    end

end