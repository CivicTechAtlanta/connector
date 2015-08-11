# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title { Faker::Lorem.words.join(" ") }
    description { Faker::Lorem.paragraph }
    url { Faker::Internet.url }
    location { Faker::Lorem.words.join }
    start_at { Time.now }
    end_at { 2.hours.from_now }
  end
end
