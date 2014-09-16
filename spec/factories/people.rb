FactoryGirl.define do
  factory :person do
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end
end
