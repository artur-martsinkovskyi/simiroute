# README

[![CircleCI](https://circleci.com/gh/artur-martsinkovskyi/simiroute.svg?style=svg)](https://circleci.com/gh/artur-martsinkovskyi/simiroute)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/145d1b8a21964e048b524d3ec1fc0a87)](https://www.codacy.com/app/deimoss42/simiroute?utm_source=github.com&utm_medium=referral&utm_content=artur-martsinkovskyi/simiroute&utm_campaign=Badge_Grade)

## Software versions

-   Ruby 2.5.3
-   Rails 5.2.2
-   PostgreSQL 9.6.10

## Installation and launch

This application is configured to run inside the Docker container. To install it you first need to install [docker](https://docs.docker.com/install/) and [docker-compose](https://docs.docker.com/compose/install/). Beware setting them to require root access because this may mess up your permissions. After you install `docker` and `docker-compose` just run
`docker-compose build` and `docker-compose up` after build finishes. You are awesome.

## How to run the test suite

When application is built run `docker-compose run web rspec`.
