# Crandexer

## Overview

This application is an indexer for R packages, based on [cran-r list](https://cran.r-project.org/src/contrib/).

The application gets the list of R packages available at the [cran repository](https://cran.r-project.org/src/contrib/PACKAGES) and displays them on a simple web interface. It also runs a daily task at 12:00 PM to update the app with new packages.

A package can be accessed at:

```
http://cran.rproject.org/src/contrib/[PACKAGE_NAME]_[PACKAGE_VERSION].tar.gz
```

## Setting Up

  -  Requirements:

      * Ruby 3.0.0
      * Redis(`brew install redis` if you don't have it already installed on your system)
      * PostgreSQL

  - Install dependencies: `bundle install`.

  - Setup datatbase: `rails db:setup`

## Usage

- Populate the database for the first time: 
  ```
  rails create:packages
  ```
  
- Start the server and access the web interface [locally](http://localhost:3000/):
  ```
  rails s
  ```

- In order to run the daily task at 12 PM to update with new packages, sidekiq must be up and running:
  ```
  bundle exec sidekiq
  ```
- Manually update packages:
  ```
  rails update:packages
  ```

## Running Tests
  ```
  bundle exec rspec
  ```
