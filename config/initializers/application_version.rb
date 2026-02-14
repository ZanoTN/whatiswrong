# Set the version of the app from the environment variable IMAGE_VERSION, which is set during the Docker build process.
# This allows us to display the version of the app in the footer and use it in other parts of the app if needed.

# config/initializers/version.rb

Rails.application.config.after_initialize do
  ApplicationVersionService.set_image_version
end
