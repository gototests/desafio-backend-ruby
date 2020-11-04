# Stock API 

Stock API application management

## Setup

### Default setup

First of all, make sure the env vars on `.env` are right with your configs.

Make sure you have Ruby installed (check `.ruby-version` file for version). You can use `asdf`, `rbenv` or `rvm`.

Install `postgresql` and start it.

After postgres installed, run the following commands:

```bash
$ bundle
$ rails db:create
$ rails db:migrate
```

### Running specs

```bash
$ bundle exec rspec
```

## Heroku application

https://stock-nexas.herokuapp.com/

## API Documentation Insomnia

You can get [Insomnia here](https://insomnia.rest/download/).

If you have postman or insomnia already installed, you can just import `insomnia.json` or `insomnia_heroku.json` and consume the API.
