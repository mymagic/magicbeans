json.array!(@activities) do |activity|
  json.extract! activity, :id, :name, :date, :venue, :description, :speaker, :speakerbio, :biolink, :keytakeaway, :prerequisite, :maxattendee, :tags, :resources
  json.url activity_url(activity, format: :json)
end
