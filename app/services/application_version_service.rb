class ApplicationVersionService
  def self.set_image_version
    # Set the application version from the environment variable, which is set during the Docker build process.
    version = ENV["IMAGE_VERSION"] || nil
    ApplicationVersion.set("image_version", version)
  end

  def self.set_online_image_version
    # Fetch the latest version from the Docker Hub API
    begin
      response = Faraday.get("https://registry.hub.docker.com/v2/repositories/zanotn/whatiswrong/tags/?page_size=3")
      if response.status == 200
        data = JSON.parse(response.body)
        version = nil

        data["results"].each do |result|
          if result["name"] != "latest"
            version = result["name"]
            break
          end
        end

        ApplicationVersion.set("online_image_version", version)
      else
        puts "Error fetching online version: #{response.status}"
      end
    rescue => e
      puts "Exception fetching online version: #{e.message}"
    end
  end

  def self.is_new_version_available?
    online_version = ApplicationVersion.get("online_image_version")
    local_version = ApplicationVersion.get("image_version")

    return false if online_version.nil? || local_version.nil?

    Gem::Version.new(online_version) > Gem::Version.new(local_version)
  end
end
