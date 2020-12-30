# Mail

[![Build Status](https://travis-ci.com/jmalcic/spina-admin-mail.svg?branch=master)](https://travis-ci.com/jmalcic/spina-admin-mail)
[![Maintainability](https://api.codeclimate.com/v1/badges/2c1604dd7f5b412daf2c/maintainability)](https://codeclimate.com/github/jmalcic/spina-admin-mail/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/2c1604dd7f5b412daf2c/test_coverage)](https://codeclimate.com/github/jmalcic/spina-admin-mail/test_coverage)

*Mail* is a plugin for [Spina](https://www.spinacms.com 'Spina website') (a [Rails](http://rubyonrails.org 'Ruby on Rails website') content management system) to add email functionality.

## Usage

The plugin will add an **Email** item to Spina's primary navigation menu.

After installing the plugin, you just need to start your server in the usual way:
```bash
$ rails s
```

## Installation

### From scratch

You'll need [Rails](http://rubyonrails.org 'Ruby on Rails website') installed if it isn't already.
Read how to do this in the [Rails getting started guide](https://guides.rubyonrails.org/getting_started.html 'Getting Started with Rails').

Then run:
```bash
$ rails new your_app --database postgresql
$ rails db:create
$ rails active_storage:install
```

Add this line to your application's Gemfile:

```ruby
gem 'spina'
```

And then execute:
```bash
$ bundle:install
```

Run the Spina install generator:
```bash
$ rails g spina:install
```

And follow the prompts.
Then follow the instructions below.

### For existing Spina installations

Add this line to your application's Gemfile:

```ruby
gem 'spina-admin-mail', github: 'jmalcic/spina-admin-mail'
```

You'll then need to install and run the migrations from Conferences (the Spina install generator does this for Spina).

First install the migrations and then migrate the database:
```bash
$ rake spina_admin_mail:install:migrations
$ rake db:migrate
```

### Configuring the main Rails app

Conferences requires a job queueing backend for import functionality. Read about this in the Rails guide covering
[Active Job](https://guides.rubyonrails.org/active_job_basics.html).

## Contributing

You're very welcome to contribute, particularly to translations.
If there's a bug, or you have a feature request, make an issue on GitHub first.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
