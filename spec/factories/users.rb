require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.name Faker::Name.name
    f.ic Faker::Number.number(12)
    f.email Faker::Internet.email
    f.password Faker::Internet.password
    f.phone Faker::PhoneNumber.cell_phone
    f.confirmed_at Time.now
  end
end