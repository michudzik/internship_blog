FactoryBot.define do
  factory :user do
    first_name    { Faker::Name.first_name }
    last_name     { Faker::Name.last_name }
    password      'secret'
    email         { "#{Faker::Name.first_name}@example.com" }
    confirmed_at  { DateTime.now }
  end
end
