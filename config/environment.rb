# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
Organizer::Config.access_token = Magicbeans.eventbrite_api
Workspace::Application.config.time_zone = Magicbeans.time_zone
