require 'faker'

FactoryGirl.define do
  factory :user do |f|
    f.email Faker::Internet.email
    f.password Faker::Internet.password
    f.name Faker::Name.name
    f.ic Faker::Base.numerify('######-##-####')
    f.phone Faker::PhoneNumber.cell_phone
  end
end