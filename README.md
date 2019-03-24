BeardBot

This is a basic chatbot built in Ruby on Rails to get more familiar with the framework, and right now is very much a work in progress. Language pattern recognition is rough but I'll be hooking it up to Wit.ai soon to test that out.

Some refactoring needs to be done later on, especially for my css but as this was very experimental early on I've kept notes separately and what needs to be reorganised, so don't destroy me for the gratuitous use of !important in my stylesheet :D

* Ruby version: ruby 2.5.3

* System dependencies:

Everything can be found in the gemfile but notable additions to a base project are:
bootstrap-sass 3.4.1
authlogic 5.0.1
programr 0.0.2
jquery-rails 4.3.3

Also, Windows doesn't play nice with sqlite3 so I recommend building this on your choice Linux distro if possible, otherwise you can go with my solution of pointing at a specific git branch (which you can find near the top of my Gemfile. This is poor practice, I don't recommend doing this but for a test project it should be fine. I'll be deploying this on a Linux server and removing that for the real production build)

* Database creation:
Run the migrations, the structure is pretty straightforward so you don't need to do anything out of the ordinary.
