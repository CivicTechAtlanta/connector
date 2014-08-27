# Requirements

See REQUIREMENTS.md.

# Postgresql Setup:

- Open up a postgresql session and enter `CREATE USER connector WITH LOGIN SUPERUSER;`
- `rake db:setup`
- `rake db:setup RAILS_ENV=test`
- `rake db:seed`

# Contributing:

- Create a branch on this project to work on `git checkout master && git pull origin master && git checkout -b your-feature-name`
- Do your changes
- Push to git and create a pull request
- Other people on the project review and you review other peoples before merging

# Dont:

- Use scaffold generators. They create a bunch of unnecessary code and don't allow for thinking about the end user experience
