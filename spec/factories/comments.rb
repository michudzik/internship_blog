FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentence(3) }
    user
    post
  end
end