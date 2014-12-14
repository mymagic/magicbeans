module Organizer
  class Ticket < Organizer::Event
    # Making getter/setter methods on the instance
    attr_accessor :name, :description, :qty, :price, :eid, :response

    def initialize(params={})
      url_escape(params)
      super()
    end

    def save
      payload = "ticket_class.name=#{CGI::escape(self.name)}&ticket_class.description=#{self.description}&ticket_class.quantity_total=#{self.qty}&ticket_class.cost.currency=#{self.currency}&ticket_class.cost.value=#{self.price}"
      self.response = connection.post "/v3/events/#{self.eid}/ticket_classes/", payload
      self.response.status
    end
  end
end