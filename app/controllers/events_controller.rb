# class EventsController < ApplicationController
#   before_filter :authenticate_user!
#   before_action :set_configs, only: [:new, :new_ticket, :publish, :unpublish]
#   load_and_authorize_resource
#
#   def new_event
#     e = Event.new('An event name', 'The definitive description of the event', Time.new(2015, 12, 01).utc.iso8601, Time.new(2015, 12, 31).utc.iso8601)
#     payload = "event.name.html=#{CGI::escape(e.name)}&event.description.html=#{CGI::escape(e.description)}&event.organizer_id=#{@organizer_id}&event.start.utc=#{CGI::escape(e.start)}&event.start.timezone=#{@timezone}&event.end.utc=#{CGI::escape(e.end)}&event.end.timezone=#{@timezone}&event.currency=#{@currency}&event.venue_id=&event.online_event=on&event.logo.id=&event.category_id=&event.subcategory_id=&event.format_id=&event.password=&event.capacity="
#     response = @connection.post "/v3/events/", payload
#     @eid = JSON.parse(response.body)['id']
#   end
#
#   def new_ticket(name, description, qty, price)
#     raise "event id is missing!, please create an event and try again" if @eid.nil?
#     payload = "ticket_class.name=#{CGI::escape(name)}&ticket_class.description=#{CGI::escape(description)}&ticket_class.quantity_total=#{qty}&ticket_class.cost.currency=#{@currency}&ticket_class.cost.value=#{price}&ticket_class.sales_start=&ticket_class.sales_end=&ticket_class.sales_start_after=&ticket_class.minimum_quantity=&ticket_class.maximum_quantity=&ticket_class.auto_hide_before=&ticket_class.auto_hide_after="
#     @connection.post "/v3/events/#{@eid}/ticket_classes/", payload
#   end
#
#   def publish()
#     raise "event id is missing!, please create an event and try again" if @eid.nil?
#     connection.post "/v3/events/#{@eid}/publish/"
#   end
#
#   def unpublish()
#     raise "event id is missing!, please create an event and try again" if @eid.nil?
#     @connection.post "/v3/events/#{@eid}/unpublish/"
#   end
#
#   private
#   # Use callbacks to share common setup or constraints between actions.
#   def set_configs
#     @connection = Faraday.new(
#         "https://www.eventbriteapi.com/",
#         {
#             params: {
#                 token: 'BJKS6GXA7X2ZZLMH4EHT'
#             }
#         }
#     )
#     @organizer_id = 7823757604
#     @timezone = CGI::escape('Asia/Kuala_Lumpur')
#     @currency = CGI::escape('MYR')
#   end
#
#   # Never trust parameters from the scary internet, only allow the white list through.
#   def event_params
#     # params.require(:event).permit()
#   end
# end