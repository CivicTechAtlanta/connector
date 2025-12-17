# !! ARCHIVED - THIS REPO IS NO LONGER ACTIVELY USED OR MAINTAINED !!


# Getting started

The following is a brief guide on how you can get started working on connector:

# Postgresql Setup:

If you do not have Postgres on your machine, please install it: http://www.postgresql.org/download/

Once installed run:

**Terminal**

    bundle install
    rake db:setup
    rake db:setup RAILS_ENV=test
    rake db:seed

# Facebook Setup

In order to use the login feature, you will have to supply the FB App ID and Secret codes to the application. In Connector, we do this through the use of the dotenv-rails gem (https://rubygems.org/gems/dotenv-rails), which allows us to create a local environment file that we can define these values in.

In the root of the application on your local machine, create a file named `.env`. Then contact one of the members of the connector group for the proper content for the file (since these values are secret!).

# Contributing:

We ask that you follow these rules when contributing:

- Always create a new branch to commit your changes to:

**Terminal**

    git checkout master
    git pull origin master
    git checkout -b your-feature-name


- When you are ready to submit your changes, push everything to your branch and create a pull request

- Wait for team approval to merge your changes

- DO NOT use scaffold generators. They create a bunch of unnecessary code and don't allow for thinking about the end user experience
