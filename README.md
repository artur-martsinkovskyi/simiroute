# README

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/0d06fec8a6b14d419648a588a4c552de)](https://app.codacy.com/app/deimoss42/simiroute?utm_source=github.com&utm_medium=referral&utm_content=artur-martsinkovskyi/simiroute&utm_campaign=Badge_Grade_Settings)

## Software versions

-   Ruby 2.5.1
-   Rails 5.2.2
-   SQLite 3.19

## Installation and launch

_NOTE: These steps cover installation from scratch, if you already have some of the dependencies just miss an according step._

1.  Install rvm at [rvm.io](https://rvm.io).
2.  Run rvm install 2.5.1
3.  Install sqlite3 if it is not already installed [here](https://www.sqlite.org/index.html).
4.  Run `bundle install` in the project directory. This may take some time due to C extensions build process.
5.  Run `rails db:setup` to setup database.
6.  Fire up the server with `rails s`.
7.  You're awesome.

## Configuration

Zero configuration is needed on current stage of development.

## How to run the test suite

Run `rspec`.
