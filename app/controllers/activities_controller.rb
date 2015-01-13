class ActivitiesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_activity, only: [:show, :edit, :update, :destroy, :create_event, :tweet, :create_gcal, :share]
  load_and_authorize_resource
  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  # def new
  #   @activity = Activity.new
  # end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  # def create
  #   @activity = Activity.new(activity_params)
  #
  #   respond_to do |format|
  #     if @activity.save
  #       format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
  #       format.json { render :show, status: :created, location: @activity }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @activity.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
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

  # DELETE /activities/1
  # DELETE /activities/1.json
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
    @event = Organizer::Event.new(
      name: @activity.name,
      description: @activity.description,
      start: @activity.start_date.to_time,
      end: @activity.end_date.to_time,
      online_event: @activity.online,
      currency: "MYR",
      listed: @activity.listed)

    if (!@activity.event_id)
      @event_response = Organizer.events(event: @event).post
      if (@event_response.status == 200)
        @activity.event_id = @event_response.body['id']
        @activity.save
        redirect_to activity_path(@activity), success: 'Successfully created a event!'
      else
        redirect_to activity_path(@activity), alert: "[#{@event_response.status}] There was an error creating the event"
      end
    else
        redirect_to activity_path(@activity), alert: 'Event has already been created'
    end
  end

  def tweet
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = Magicbeans.twitter_consumer_key
      config.consumer_secret     = Magicbeans.twitter_consumer_secret
      config.access_token        = Magicbeans.twitter_access_token
      config.access_token_secret = Magicbeans.twitter_access_token_secret
    end

    begin
      message = params[:tweet][:message]
      if !message.blank?
        @send_tweet = client.update(message)
        redirect_to activity_path(@activity), success: 'Successfully tweeted!'
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

    # Initialize the client
    client = Google::APIClient.new(application_name: 'MagicBeans', application_version: '0.0.1')
    # load and decrypt private key
    key = Google::APIClient::KeyUtils.load_from_pkcs12( File.join(Rails.root, '..', '..', 'keyfile.p12').to_s , 'notasecret')
    # generate request body for authorization
    client.authorization = Signet::OAuth2::Client.new(
                             :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
                             :audience             => 'https://accounts.google.com/o/oauth2/token',
                             :scope                => 'https://www.googleapis.com/auth/calendar',
                             :issuer               =>  Magicbeans.google_service_account_email,
                             :signing_key          =>  key
                             )

    # fetch access token
    client.authorization.fetch_access_token!
    # load API definition
    service = client.discovered_api('calendar', 'v3')
    # access API by using client
    @set_event = client.execute(:api_method => service.events.insert,
                                :parameters => {'calendarId' => Magicbeans.google_calendar_id },
                                :body => JSON.dump(@gcal_event),
                                :headers => {'Content-Type' => 'application/json'})

    if @set_event
      redirect_to activity_path(@activity), success: 'Successfully posted activity to Google Calendar!'
    else
      redirect_to activity_path(@activity), alert: "There was an error posting the event to Google Calendar"
    end
  end

  def share
      page = Koala::Facebook::API.new(Magicbeans.fb_page_access_token)
      message = params[:share][:message]
      share_event = Organizer.events(event: @event).get
      page.put_wall_post(message, {
                          # "name" => "name temp",
                          #  "link" => "http://www.site-temp.com/",
                          #  "description" => "I Know temp Description",
                          #  "picture" => "http://site-temp.com/image.jpg"
                          "name" => @activity.name,
                          "link" => share_event.body["url"],
                          "caption" => @activity.name,
                          "description" => @activity.description,
                          "picture" => share_event.body["logo"]
                          })

      redirect_to activity_path(@activity), success: "Shared to Facebook successfully!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:id, :name, :start_date, :end_date, :venue, :description, :speaker, :speakerbio, :biolink, :keytakeaway, :prerequisite, :maxattendee, :tags, :resources)
    end
end
