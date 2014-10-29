FactoryGirl.define do
  factory :project do
    name { Faker::Lorem.word }
    short_description { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end
end
