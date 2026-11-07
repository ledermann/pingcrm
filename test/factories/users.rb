FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Doe' }
    email { Faker::Internet.unique.email }
    # No weak password: Chrome would show a leak warning that swallows clicks
    password { SecureRandom.base58(24) }
  end
end
