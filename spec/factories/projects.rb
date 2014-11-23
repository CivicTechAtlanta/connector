FactoryGirl.define do
  factory :project do
    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    url { Faker::Internet.url }
  end
end
