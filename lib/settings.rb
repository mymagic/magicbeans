module Settings
  def self.load
    begin
	Organizer::Config.access_token = Magicbean.eventbrite_api
	Magicbean.all
	rescue ActiveRecord::StatementInvalid
		Rails.logger.info "Please configure the app in the settings pages and restart the server"
	end
  end
end