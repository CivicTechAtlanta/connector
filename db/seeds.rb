# Destroy existing
Project.destroy_all
Person.destroy_all
Organization.destroy_all

projects = []
people = []
organizations = []

5.times do
  projects << FactoryGirl.create(:project)
end

5.times do
  people << FactoryGirl.create(:person)
end

5.times do
  organizations << FactoryGirl.create(:organization)
end

projects[0].people << people[0]
projects[0].people << people[1]
projects[0].people << people[2]

projects[1].people << people[3]
projects[1].people << people[4]

projects[2].people << people[0]
projects[2].people << people[4]

projects[4].people << people[0]
projects[4].people << people[1]
projects[4].people << people[4]

projects[0].organizations << organizations[0]
projects[0].organizations << organizations[1]

projects[2].organizations << organizations[3]
projects[2].organizations << organizations[4]
