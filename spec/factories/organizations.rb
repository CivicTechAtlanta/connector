FactoryGirl.define do
  factory :organization do
    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
  end
end
