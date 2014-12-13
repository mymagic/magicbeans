class Event
  attr_accessor :response, :oid, :name, :description, :start, :end, :tz, :currency, :online, :listed
  def initialize(params={})
    params.each do |attr, value|
      self.public_send("#{attr}=", (value.is_a? String) ? CGI::escape(value) : value)
    end if params

    super()
  end

  def save
    connection = connect()
    payload = "event.name.html=#{@name}&event.description.html=#{@description}&event.organizer_id=#{@organizer_id}&event.start.utc=#{@start}&event.start.timezone=#{@tz}&event.end.utc=#{@end}&event.end.timezone=#{@tz}&event.currency=#{@currency}&event.venue_id=&event.online_event=#{@online}&event.listed=#{@listed}"
    @response = connection.post "/v3/events/", payload
  end

  def create_ticket(name, description, qty, price)
    raise "event is missing!, please create an event and try again" if @response.nil?
    connection = connect()
    payload = "ticket_class.name=#{CGI::escape(name)}&ticket_class.description=#{CGI::escape(description)}&ticket_class.quantity_total=#{qty}&ticket_class.cost.currency=#{@currency}&ticket_class.cost.value=#{price}"
    connection.post "/v3/events/#{JSON.parse(@response.body)['id']}/ticket_classes/", payload
  end

  def publish
    raise "event is missing!, please create an event and try again" if @response.nil?
    connection = connect()
    connection.post "/v3/events/#{JSON.parse(@response.body)['id']}/publish/"
  end

  def unpublish
    raise "event is missing!, please create an event and try again" if @response.nil?
    connection = connect()
    connection.post "/v3/events/#{JSON.parse(@response.body)['id']}/unpublish/"
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