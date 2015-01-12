class ActivitiesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_activity, only: [:show, :edit, :update, :destroy, :create_event, :create_gcal]
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
      start: @activity.start.to_time,
      end: @activity.end.to_time,
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

  def create_gcal
    @event = {
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
    key = Google::APIClient::KeyUtils.load_from_pkcs12( File.join(Rails.root, '..', '..', 'MagicBeans-931630ca9e3e.p12').to_s , 'notasecret')
    # generate request body for authorization
    client.authorization = Signet::OAuth2::Client.new(
                             :token_credential_uri => 'https://accounts.google.com/o/oauth2/token',
                             :audience             => 'https://accounts.google.com/o/oauth2/token',
                             :scope                => 'https://www.googleapis.com/auth/calendar',
                             # :person               => 'admin@gmail.com',
                             :issuer               =>  ENV['GOOGLE_SERVICE_ACCOUNT_EMAIL'],
                             :signing_key          =>  key
                             )

    # fetch access token
    client.authorization.fetch_access_token!
    # load API definition
    service = client.discovered_api('calendar', 'v3')
    # access API by using client
    @set_event = client.execute(:api_method => service.events.insert,
                                :parameters => {'calendarId' => ENV['GOOGLE_CALENDAR_ID'] },
                                :body => JSON.dump(@event),
                                :headers => {'Content-Type' => 'application/json'})

    if @set_event
      redirect_to activity_path(@activity), success: 'Successfully posted activity to Google Calendar!'
    else
      redirect_to activity_path(@activity), alert: "There was an error posting the event to Google Calendar"
    end
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
