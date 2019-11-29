require 'faker'

FactoryBot.define do
  factory :organization do
    name { Faker::Company.name }
    email { Faker::Internet.unique.email }
    phone { Faker::PhoneNumber.phone_number }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    region { Faker::Address.state }
    country { 'US' }
    postal_code { Faker::Address.postcode }
  end
end
