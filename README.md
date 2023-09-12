# GitReps Community Platform

[![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-rails)

[![Rails Style Guide](https://img.shields.io/badge/code_style-community-brightgreen.svg)](https://rails.rubystyle.guide)

[![CodeFactor](https://www.codefactor.io/repository/github/gitrepscommunity/platform/badge)](https://www.codefactor.io/repository/github/gitrepscommunity/platform)


## Installation and Usage Instructions

### Clone this repository

```
git clone https://github.com/GitRepsCommunity/platform.git
```


### System Dependencies
To run this Rails project as intended you will need to install:
- Docker ([Docker Desktop](https://www.docker.com/products/docker-desktop/) recommended, but if you prefer another installation method make sure to include [Compose](https://docs.docker.com/compose/)).
- [Yarn](https://yarnpkg.com/getting-started/install)


### Environment Variables
This project uses dotenv for storing local environment variables.
Create a new `.env` file at the root of the project and add the following variables:

```
POSTGRES_PASSWORD=password
```


### Running the Server
To start services run:
```
yarn run start
```

If this is the first time starting the services or new dependencies have been added (Gemfile updated) include the `--build` flag.
```
yarn run start --build
```

Create the database if it doesn't exist yet.
```
yarn run rails db:create
```


### Rails Commands
Any [Rails command](https://guides.rubyonrails.org/command_line.html#command-line-basics) can be executed in the web service container like so:
```
yarn run rails <cmd>
```

Start a rails console.
```
yarn run rails c
```

Run the rails test suite.
```
yarn run rails test
```

Generate rails templates.
```
yarn run rails g
```

Migrate the database.
```
yarn run rails db:migrate
```

Print out the routes.
```
yarn run rails routes
```


### Linting and Formatting
This project uses [Rubocop](https://rubocop.org/) for linting and formatting.
See `.rubocop.yml` for configuration.

To run the linter:
```
yarn run lint
```

To autocorrect formatting:
```
yarn run format
```