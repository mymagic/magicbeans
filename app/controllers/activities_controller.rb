class ActivitiesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_activity, only: [:show, :edit, :update, :destroy, :create_event, :tweet, :create_gcal, :share, :send_mails, :show_attendees]
  before_filter :set_twitter_client, only: [:tweet]
  load_and_authorize_resource
  skip_authorize_resource :only => [:search_query, :set_twitter_client, :show_attendees, :create_event, :set_twitter_client, :tweet, :create_gcal, :share, :send_mails]

  respond_to :html

  def search_query
    all_tags = Activity.tag_counts_on(:tags).where("name LIKE ?", "%#{params[:q]}%").limit(10).pluck(:name).map { |obj| {name: obj} }
    render json: all_tags
  end

  def index
    if params[:search]
      @activities = Activity.search(params[:search]).order("created_at DESC")
    else
      @activities = Activity.all
    end
    respond_with(@activities)
  end

  def show
  end

  def edit
  end

  def show_attendees
    request = Organizer.events(id: @activity.event_id).attendees.get
    @attendees = request.body["attendees"]
    render "attendees"
  end

  def update
    respond_to do |format|
      if @activity.update(activity_params)
        @log = Log.new(title: 'An activity has been updated', log_type: 'activities', type_id: @activity.id)
        @log.save
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @activity.destroy
    @log = Log.new(title: 'An activity has been destroyed', log_type: 'activities', type_id: @activity.id)
    @log.save
    respond_to do |format|
      format.html { redirect_to activities_url, notice: 'Activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_event
    if (@activity.event_id.nil?)
      @event = Organizer::Event.new(
        name: @activity.name,
        description: @activity.description,
        start: @activity.start_date.to_time,
        end: @activity.end_date.to_time,
        online_event: @activity.online,
        currency: "MYR",
        listed: @activity.listed)

      @event_response = Organizer.events(event: @event).post
      if (@event_response.status == 200)
        @activity.event_id = @event_response.body['id']
        @activity.status = @event_response.body['status']
        @activity.save
        redirect_to activity_path(@activity), success: 'Successfully created a event!'
      else
        redirect_to activity_path(@activity), alert: "[#{@event_response.status}] #{@event_response.body["error_description"]}"
      end
    else
        redirect_to activity_path(@activity), alert: 'Event has already been created'
    end
  end

  def set_twitter_client
  if Magicbean.twitter_consumer_key.present? && Magicbean.twitter_consumer_secret.present? && Magicbean.twitter_access_token.present? && Magicbean.twitter_access_token_secret.present?
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = Magicbean.twitter_consumer_key
        config.consumer_secret     = Magicbean.twitter_consumer_secret
        config.access_token        = Magicbean.twitter_access_token
        config.access_token_secret = Magicbean.twitter_access_token_secret
      end
    else
      redirect_to activity_path(@activity), notice: "Please configure all Twitter settings before tweeting."
    end
  end

  def tweet
    require 'open-uri'
    begin
      message = params[:tweet][:message]
      share_event = Organizer.events(id: @activity.event_id).get
      file = File.new(open(@activity.activity_img.url).path)
      if !message.blank?
        if share_event.body["logo"].present? && share_event.body["url"].present?
          @send_tweet = @client.update_with_media(message + "\n" + share_event.body["url"], file)
          redirect_to activity_path(@activity), success: 'Successfully tweeted!'
        else
          redirect_to activity_path(@activity), notice: 'Please make sure Eventbrite event is created and event logo is uploaded. Try again.'
        end
      else      
        redirect_to activity_path(@activity), alert: 'Message cannot be blank. Try again!'
      end
    rescue Twitter::Error => e
      redirect_to activity_path(@activity), alert: "#{e}"
    end
  end

  def create_gcal
    @gcal_event = {
        'summary' => @activity.name,
        'description' => @activity.description,
        'location' =>  @activity.venue,
        'start' => {'dateTime' => DateTime.parse(@activity.start_date.to_s).rfc3339
                    },
        'end' => {'dateTime' => DateTime.parse(@activity.end_date.to_s).rfc3339
                  }}
    if Magicbean.rsa_key.present? && Magicbean.google_service_account_email.present? && Magicbean.google_calendar_id.present?
      # Initialize the client
      client = Google::APIClient.new(application_name: 'Magicbean', application_version: '0.0.1')
      # load and decrypt private key
      key = OpenSSL::PKey::RSA.new Magicbean.rsa_key, 'notasecret'
      # generate request body for authorization
      client.authorization = Signet::OAuth2::Client.new(
                               :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
                               :audience             => 'https://accounts.google.com/o/oauth2/token',
                               :scope                => 'https://www.googleapis.com/auth/calendar',
                               :issuer               =>  Magicbean.google_service_account_email,
                               :signing_key          =>  key
                               )

      # fetch access token
      client.authorization.fetch_access_token!
      # load API definition
      service = client.discovered_api('calendar', 'v3')
      # access API by using client
      @set_event = client.execute(:api_method => service.events.insert,
                                  :parameters => {'calendarId' => Magicbean.google_calendar_id },
                                  :body => JSON.dump(@gcal_event),
                                  :headers => {'Content-Type' => 'application/json'})
      redirect_to activity_path(@activity), success: 'Successfully posted activity to Google Calendar!'
    else
      redirect_to activity_path(@activity), notice: "Google Calendar Settings are missing."
    end
  end

  def share
    begin
      page = Koala::Facebook::API.new(Magicbean.fb_page_access_token)
      message = params[:share][:message]
      share_event = Organizer.events(id: @activity.event_id).get
      if !message.blank?
        post_status = page.put_wall_post(message, {
                          "name" => @activity.name,
                          "link" => share_event.body["url"],
                          "caption" => @activity.name,
                          "description" => @activity.description,
                          "picture" => share_event.body["logo"]
                          })
        redirect_to activity_path(@activity), success: "Shared to Facebook successfully!"
      else      
        redirect_to activity_path(@activity), alert: 'Message cannot be blank. Try again!'
      end
    rescue Koala::Facebook::APIError => error
      redirect_to activity_path(@activity), notice: "#{error}"
    end
  end

  def send_mails
      @the_content = %Q{

      <p>#{Magicbean.mailchimp_message}</p>

      <p>Below are details of the event:</p> 

      <p><strong>Program Name : </strong>#{@activity.program.name} </div></strong>
      
      <p><strong>Event Name : </strong>#{@activity.name}</p>

      <p><strong>Event Venue : </strong>#{@activity.venue}</p>
      
      <p><strong>Description : </strong>#{@activity.description}</p>
      
      <p><strong>Date  : </strong>#{@activity.start_date} - #{@activity.end_date}</p>

      <p>Here is the link to RSVP for the event:</p>

      <p>#{Organizer.events(id: @activity.event_id).get.body["url"]}</p>

      <p>See you there!</p>
      }

    begin
      apikey = Magicbean.mailchimp_apikey
      @h = Hominid::API.new(apikey)
      list_id = params[:send_mails][:mailchimp_list_id]
        if list_id.present?
          campaign_id = @h.campaign_create('regular', 
                                     {:list_id => list_id, 
                                        :subject => 'Invitation to ' + @activity.program.name, 
                                        :from_email => @h.find_list_by_id(list_id)['default_from_email'],
                                        :from_name => @h.find_list_by_id(list_id)['default_from_name']},
                                      {:html => @the_content}
                                      )
          @h.campaign_send_now(campaign_id)
          redirect_to activity_path(@activity), success: 'Successfully sent mails!'
        else
          redirect_to activity_path(@activity), notice: 'Please select a list.' 
        end     
    rescue Hominid::APIError => error
      redirect_to activity_path(@activity), notice: "#{error}"
    end                          
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:tag_list, :id, :name, :start_date, :end_date, :venue, :description, :speaker, :speakerbio, :biolink, :keytakeaway, :prerequisite, :maxattendee, :tags, :resources, :speaker_img, :activity_img)
    end
end
