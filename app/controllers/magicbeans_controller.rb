class MagicbeansController < ApplicationController
  def settings
    @params = magicbeans_params
    @params.each do |k, v|
      if k == "time_zone"
        Magicbeans.send("#{k}=", v[:name])
      else
        Magicbeans.send("#{k}=", v)
      end
    end
    reload_settings
  end

  def magicbeans_params
    params.permit(:eventbrite_api, :twitter_api, :fb_api, :organizer_id, :twitter_message, :fb_message, :time_zone => [:name])
  end
end