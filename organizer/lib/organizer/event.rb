module Organizer
  class Event
    # Making getter/setter methods on the instance
    attr_accessor :name, :description, :start, :end, :online, :listed, :response, :connection, :tz, :oid, :currency

    def initialize(params={})
      url_escape(params)
      self.tz= CGI::escape('Asia/Kuala_Lumpur')
      self.currency= CGI::escape('MYR')
      self.oid = 7823757604
      self.connection = Faraday.new("https://www.eventbriteapi.com/", {params: {token: ENV['EVENTBRITEAPIKEY']}})
      super()
    end

    def save
      payload = "event.name.html=#{self.name}&event.description.html=#{self.description}&event.organizer_id=#{self.oid}&event.start.utc=#{self.start}&event.start.timezone=#{self.tz}&event.end.utc=#{self.end}&event.end.timezone=#{self.tz}&event.currency=#{self.currency}&event.venue_id=&event.online_event=#{self.online}&event.listed=#{self.listed}"
      self.response = self.connection.post "/v3/events/", payload
      self.response.status
    end

    def publish
      raise "event is missing!, please create an event and try again" if self.response.nil?
      @connection.post "/v3/events/#{JSON.parse(self.response.body)['id']}/publish/"
    end

    def unpublish
      raise "event is missing!, please create an event and try again" if self.response.nil?
      @connection.post "/v3/events/#{JSON.parse(self.response.body)['id']}/unpublish/"
    end

    private
    def url_escape(params)
      params.each do |attr, value|
        self.public_send("#{attr}=", (value.is_a? String) ? CGI::escape(value) : value)
      end if params
    end
  end
end