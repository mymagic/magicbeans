require 'faker'

FactoryGirl.define do
  factory :program do |f|
    f.name Faker::Lorem.word
    f.description Faker::Lorem.sentence
    f.speaker Faker::Name.name
    f.speakerbio Faker::Lorem.word
    f.biourl Faker::Internet.url
    f.keytakeways Faker::Company.catch_phrase
    f.tags Faker::Lorem.word
    f.resources Faker::Internet.url
  end
end