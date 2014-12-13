class Event
  def initialize(name, description)
    @name = CGI::escape(name)
    @description = CGI::escape(description)
    @start = CGI::escape('2015-01-01T16:00:32Z')
    @end = CGI::escape('2015-01-22T16:03:37Z')
    @timezone = CGI::escape('Asia/Kuala_Lumpur')
    @organizer_id = 7823757604
    @currency = CGI::escape('MYR')
    @online = true
    @listed = true
    @eid = nil
  end

  def new_event
    connection = connect()
    payload = "event.name.html=#{@name}&event.description.html=#{@description}&event.organizer_id=#{@organizer_id}&event.start.utc=#{@start}&event.start.timezone=#{@timezone}&event.end.utc=#{@end}&event.end.timezone=#{@timezone}&event.currency=#{@currency}&event.venue_id=&event.online_event=#{@online}&event.listed=#{@listed}"
    response = connection.post "/v3/events/", payload
    @eid = JSON.parse(response.body)['id']
  end

  def new_ticket_class(name, description, qty, price)
    raise "event id is missing!, please create an event and try again" if @eid.nil?
    connection = connect()
    payload = "ticket_class.name=#{CGI::escape(name)}&ticket_class.description=#{CGI::escape(description)}&ticket_class.quantity_total=#{qty}&ticket_class.cost.currency=#{@currency}&ticket_class.cost.value=#{price}"
    connection.post "/v3/events/#{@eid}/ticket_classes/", payload
  end

  def publish()
    raise "event id is missing!, please create an event and try again" if @eid.nil?
    connection = connect()
    connection.post "/v3/events/#{@eid}/publish/"
  end

  def unpublish()
    raise "event id is missing!, please create an event and try again" if @eid.nil?
    connection = connect()
    connection.post "/v3/events/#{@eid}/unpublish/"
  end

  private
  def connect
    Faraday.new(
        "https://www.eventbriteapi.com/",
        {
            params: {
                token: ENV['EVENTBRITEAPIKEY']
            }
        }
    )
  end
end