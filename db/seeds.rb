# Destroy existing
Project.destroy_all
Person.destroy_all
User.destroy_all

projects = []
people = []
users = []

6.times do
  projects << FactoryGirl.create(:project)
end

5.times do
  people << FactoryGirl.create(:person)
end

users << FactoryGirl.create(:user, person: people[0])
users << FactoryGirl.create(:user, person: people[1])

projects[0].people << people[0]
projects[0].people << people[1]
projects[0].people << people[2]

projects[0].comments.create!(title: Faker::Lorem.sentence, comment: Faker::Lorem.paragraph, user: users[0])
projects[0].comments.create!(title: Faker::Lorem.sentence, comment: Faker::Lorem.paragraph, user: users[1])
projects[0].comments.create!(title: Faker::Lorem.sentence, comment: Faker::Lorem.paragraph, user: users[0])

projects[0].tag_list.add("ruby on rails")
projects[0].tag_list.add("website")
projects[0].save

projects[1].people << people[3]
projects[1].people << people[4]

projects[1].tag_list.add("ruby on rails")
projects[1].save

projects[2].people << people[0]
projects[2].people << people[4]

projects[4].people << people[0]
projects[4].people << people[1]
projects[4].people << people[4]

projects[4].tag_list.add("website")
projects[4].tag_list.add("computer")
projects[4].save

projects[5].finished = true
projects[5].save