FactoryGirl.define do
  factory :person do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    image { "http://www.discoposse.com/wp-content/uploads/2014/08/test-all-the-things.jpg" }
  end
end
