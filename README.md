# README

This README would normally document whatever steps are necessary to get the
application up and running.

##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [2.7.4](https://github.com/kienhaw/hometime-assessment/blob/master/.ruby-version#L4)
- Rails [6.1.3](https://github.com/kienhaw/hometime-assessment/blob/master/Gemfile#L7)
- Database: [PostgresQL 13](https://github.com/kienhaw/hometime-assessment/blob/master/config/database.yml#L18)

##### 1. Check out the repository

```bash
git clone https://{{username}}@github.com/kienhaw/hometime-assessment.git
```

##### 2. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
```

##### 3. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000
