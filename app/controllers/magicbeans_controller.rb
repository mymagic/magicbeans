class MagicbeansController < ApplicationController
  before_filter :authenticate_user!
  def settings
    @params = magicbeans_params
    @params.each do |k, v|
      if k == "time_zone"
        Magicbeans.send("#{k}=", v[:name])
      else
        Magicbeans.send("#{k}=", v)
      end
    end
    Settings.load
  end

  def magicbeans_params
    params.permit(:eventbrite_api, :twitter_consumer_key, :twitter_consumer_secret, :twitter_access_token, :twitter_access_token_secret, :google_service_account_email, :google_calendar_id, :fb_api, :organizer_id, :twitter_message, :fb_message, :time_zone => [:name])
  end
end