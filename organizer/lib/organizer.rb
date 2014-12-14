require "faraday"
Dir[File.dirname(__FILE__) + '/organizer/*.rb'].each do |file|
  require file
end

module Organizer
end