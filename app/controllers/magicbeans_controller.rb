class MagicbeansController < ApplicationController
  def settings
    @params = magicbeans_params
    @params.each do |k, v|
      Magicbeans.send("#{k}=", v)
    end
  end

  def magicbeans_params
    params.permit(:eventbrite_api, :twitter_api, :fb_api, :organizer_id, :twitter_message, :fb_message)
  end
end