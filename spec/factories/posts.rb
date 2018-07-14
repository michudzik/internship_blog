FactoryBot.define do
  factory :post do
    title   { Faker::Lorem.characters(10) }
    content 'Lorem ipsum'
    author
  end 
end