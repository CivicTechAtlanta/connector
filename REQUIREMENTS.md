## The Connector

The Connector is a tool for managing and tracking the projects of the Code for Atlanta Brigade. It will power codeforatlanta.org.

## Functional Requirements

### Objects

Four main object types:

* People
* Projects
* Events
* Organizations

All four main object types are taggable.

#### Person

A person can be optionally linked to a user account. But a person can exist in the app without a user account.

A person belongs to projects and organizations. A person attends events.

#### Project

A project is worked on at an event. It is worked on by people and linked to organizations.
-Name
-Description
-Type
-Members
-GitHub Link
-Where it's located

#### Event

Many people and organizations can attend an event. An event has a list of projects that were worked on during it.
-Events can be subscribed to via iCalendar
-



#### Organization

An organization has many people. An organization can attend an event. And an organization can be linked to a project.


### Main Screens

#### Homepage

The homepage displays current projects, upcoming events, and a search box for tags.

#### Person page

A person page displays profile information, the list of events they have attended, the projects they've worked on, and the organizations they belong to.

#### Project page

A project page displays relevant information about the project, a list of people and organizations who work on it, and a history of events where it's been worked on.

#### Event page

An event page displays relavant information about the event, a list of people and organizations who attended it, and a list of projects worked on during it.

#### Organization page

An organization page displays relevant information about the organization, a list of people who belong to it, a list of projects it's involved with, and events it's attended.


### Other Considerations

A simple page management system is needed for pages like About.

User accounts should not use passwords. Instead, use Facebook, Twitter, and [Email-only](https://github.com/plataformatec/devise/wiki/How-To:-Email-only-sign-up) signup.


## Technical Requirements

The Connector is a Rails app, following "The Rails Way" as closely as possible. For features not built into Rails, use the most popular gem available. The project should be designed to deploy on Heroku and follow Heroku's best practices for deployment. The HTML and CSS should be built on Boostrap. 


