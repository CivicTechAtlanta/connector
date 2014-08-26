FactoryGirl.define do
  factory :organization do
    name { "Organization #{Faker::Lorem.word}" }
    description { Faker::Lorem.paragraph }
  end
end
