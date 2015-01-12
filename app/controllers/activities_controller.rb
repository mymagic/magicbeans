class ActivitiesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_activity, only: [:show, :edit, :update, :destroy, :create_event, :tweet]
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

  def tweet
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:id, :name, :date, :venue, :description, :speaker, :speakerbio, :biolink, :keytakeaway, :prerequisite, :maxattendee, :tags, :resources)
    end
end
