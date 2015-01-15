require "settings"

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

  def generate_page_token
    oauth = Koala::Facebook::OAuth.new(Magicbeans.fb_app_id, Magicbeans.fb_app_secret)
    access_token = Magicbeans.fb_user_access_token

    if access_token.present? && Magicbeans.fb_app_id.present? && Magicbeans.fb_app_secret.present?
      new_access_info = oauth.exchange_access_token_info(access_token)
      new_access_token = new_access_info["access_token"]
      @user_graph = Koala::Facebook::API.new(new_access_token)
      page_token = @user_graph.get_page_access_token(Magicbeans.fb_page_id)
      Magicbeans.fb_page_access_token = page_token
      redirect_to settings_path(:anchor => "fb_page_access_token"), notice: "Page token generated"
    else
      redirect_to settings_path, notice: "Please insert Facebook User Access Token before generating Page Access Token"
    end
  end

  def magicbeans_params
    params.permit(:eventbrite_api, :twitter_consumer_key, :twitter_consumer_secret, :twitter_access_token, :twitter_access_token_secret, :google_service_account_email, :google_calendar_id, :rsa_key, :fb_app_id, :fb_app_secret, :fb_user_access_token, :fb_page_access_token, :fb_page_id, :organizer_id, :twitter_message, :fb_message, :time_zone => [:name])
  end

end