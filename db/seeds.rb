# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

account = Account.create!(name: 'Acme Corporation')

account.users.create!(
  first_name: 'John',
  last_name: 'Doe',
  email: 'johndoe@example.com',
  password: 'secret',
  owner: true
)

5.times do
  account.users.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: 'secret',
    owner: false
  )
end

organizations = Array.new(100) do
  account.organizations.create!(
    name: Faker::Company.unique.name,
    email: Faker::Internet.unique.email,
    phone: Faker::PhoneNumber.phone_number,
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    region: Faker::Address.state,
    country: 'US',
    postal_code: Faker::Address.postcode
  )
end

100.times do
  account.contacts.create!(
    organization: organizations.sample,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    phone: Faker::PhoneNumber.phone_number,
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    region: Faker::Address.state,
    country: 'US',
    postal_code: Faker::Address.postcode
  )
end
