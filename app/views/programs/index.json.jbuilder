json.array!(@programs) do |program|
  json.extract! program, :id, :name, :description, :speaker, :speakerbio, :biourl, :keytakeways, :tags, :resources
  json.url program_url(program, format: :json)
end
