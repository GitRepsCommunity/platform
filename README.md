# GitReps Community Platform

[![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-rails)

[![Rails Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rails.rubystyle.guide)


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


## Using Docker

To start services run:
```
docker compose up
```

If new dependencies have been added (Gemfile updated) include the `--build` flag.
```
docker compose up --build
```

Any commands to be executed in the web service (rails app)
can be done with the following:
```
docker compose run web <cmd>
```

If the database doesn't exist yet run:
```
docker compose run web rake db:create
```


## Environment Variables
This project uses dotenv for storing local environment variables.
Create a new `.env` file at the root of the project and add the following variables:

```
POSTGRES_PASSWORD=password
```

## Linting and Formatting
This project uses [Rubocop](https://rubocop.org/) for linting and formatting.
See `.rubocop.yml` for configuration.

To run the linter:
```
docker compose run web rubocop
```

To autocorrect formatting:
```
docker compose run web rubocop -x
```