# Requirements

See REQUIREMENTS.md.

# Postgresql Setup:

- Open up a postgresql session and enter `CREATE USER connector WITH LOGIN SUPERUSER;`
- `rake db:setup`
- `rake db:setup RAILS_ENV=test`
