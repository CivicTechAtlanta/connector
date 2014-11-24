FactoryGirl.define do
  factory :project do
    name { Faker::Lorem.words.join(" ") }
    description { Faker::Lorem.paragraph }
    urls {
      [
          ["Code Repository", Faker::Internet.url],
          ["Website", Faker::Internet.url]
      ]
    }
  end
end
