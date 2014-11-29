require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.name Faker::Name.name
    f.ic Faker::Base.numerify('######-##-####')
    f.email Faker::Internet.email
    f.password Faker::Internet.password
    f.phone Faker::PhoneNumber.cell_phone
  end
end