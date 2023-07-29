# GitReps Community

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
   - RVM
   - chruby
   - rbenv
   - asdf

## 3: HomeBrew installation:

### Install Ruby:
```
brew install ruby
```

### Verifying Ruby version:
Most Ruby projects will contain a .ruby-version file with the expected version of Ruby to run.
You can change your version of Ruby using a version manager like RVM.

### Installing a version manager for Ruby (RVM):
As a first step install GPG keys used to verify installation package:
```
brew install gnupg 

gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
```

Install RVM (development version):
```
\curl -sSL https://get.rvm.io | bash
```

View available versions of Ruby:
```
rvm list
```

Install specific version of Ruby (3.1.4 for this project as of 7/28/2023):
```
rvm install 3.1.4
```
#### NOTE: 
If you are having installation/compilation issues with rvm install run:
```
rvm install 3.1.4 --with-openssl-dir={path to openssl@1.1}
```

You can find your openssl path on Linux/Unix systems by running:
```
which openssl
```

### Installing Rails:
Recommended version: ```7.0.6```
```
gem install rails -v 7.0.6
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
