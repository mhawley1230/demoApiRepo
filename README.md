# NFL API

### Requirements
**Windows**
+ [Ruby 2.4.4+](https://rubyinstaller.org/) (Devkit version recommended)
+ [Postgres 9.6+](https://www.postgresql.org/download/windows/)

**Mac**
+ [Homebrew](https://brew.sh/)
+ Ruby 2.4.4+
```sh
  $ brew install ruby
```
+ PostgreSQL
```
  $ brew install postgresql
```

### Clone Repository
```sh
  $ git clone https://github.com/nate01776/demoApiRepo.git
  $ cd ./demoApiRepo
```

### Install dependencies
```sh
  $ gem install bundler
  $ bundle install
  $ bundle update
```

### Populate DB w/scraped values
```sh
  $ psql -U postgres -c "CREATE DATABASE nfl_scraper_development"
  $ pg_restore -c -i -U postgres -d nfl_scraper_development -v "./pgbackup/nflbackup.tar" -W
```
This will unpack the tarball that is in the repository, create the correct tables and seed values into them

### Start the server
```sh
  $ ruby app.rb
```

### Test the server
```sh
  curl localhost:4567/games?week=all
```
This call should return 224 results
