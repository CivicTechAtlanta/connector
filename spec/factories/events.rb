FactoryGirl.define do
  factory :event do
    name { "Event #{Faker::Lorem.word}" }
    description { Faker::Lorem.paragraph }
  end
end
