FactoryBot.define do
  factory :commentator do
    name { Faker::Name.first_name }
  end
end