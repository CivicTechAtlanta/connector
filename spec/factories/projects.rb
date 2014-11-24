FactoryGirl.define do
  factory :project do
    name { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    urls {
      [
          {
              "Code Repository" => Faker::Internet.url
          },
          {
              "Website" => Faker::Internet.url
          }
      ]
    }
  end
end
