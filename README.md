# GitReps Community Platform

## Installation and Usage Instructions

## 1: Clone this repository

```
git clone https://github.com/GitRepsCommunity/platform.git
```

## 2: System Dependencies:
To run this Rails project as intended you will need to install:
- Ruby
- Ruby on Rails
- A Ruby version manager (optional but recommended)
   - [RVM](https://rvm.io/)
   - [chruby](https://github.com/postmodern/chruby)
   - [rbenv](https://github.com/rbenv/rbenv)
   - [asdf](https://asdf-vm.com/)

## 3: HomeBrew installation:

### Install Ruby:
Reference the .ruby-version file for recommended Ruby verison. Use flag -v followed by the version number.
```
brew install ruby
```

### Installing Rails:
Reference the Gemfile for recommended Rails verison. Use flag -v followed by the version number.
```
gem install rails
```

## 4: Running the Server:
To finish installing necessary gems and dependencies, run:
```
bundle install
```

To run the development server, run:
```
rails server
```

## 5: Installing Postgres
To install Postgres using brew, run:
```
brew install postgresql
```
You may need to run ```brew tap homebrew/core``` if brew does not recognize postgresql as a current library.



---------------------------------------------------------------------------

This README still needs to document whatever steps are necessary to get the
application up and running.

Things left to cover:

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
