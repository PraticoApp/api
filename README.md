[![Build Status](https://travis-ci.org/PraticoApp/api.svg?branch=master)](https://travis-ci.org/PraticoApp/api)

# PRÁTICO

#### Setup
To run the API, follow the steps below:
```shell
bundle install
bundle exec figaro install
```
Create a PostgreSQL user named `pratico` like this:
```shell
sudo -u postgres createuser -s pratico
sudo -u postgres psql
\password pratico
\q
```
The `figaro` gem (installed on the first step) will generate the unversioned file `config/application.yml`. Copy and paste the content from `config/application.yml.example` to `config/application.yml` and fill in the data needed.

After this, execute the following steps:
```shell
rake db:create
rake db:migrate
```
Finally, run the API:
```shell
rails s
```

#### Tests and coverage
Run the tests using:
```shell
bundle exec rspec
```
You can check the coverage for the project opening the `coverage/index.html` generated every time you run the RSpec.

#### Commit
Before pushing a commit, be sure to run the Rubocop and the tests:
```shell
rubocop
bundle exec rspec
```
