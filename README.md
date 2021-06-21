
BooksManager API
======

### QUICK IDEAS

1. We don't want to expose database ids which suggests sequencies (ex: User id 1, 2, 3) and that's why we use `external_id` to reference the database record externally.
2. Because of the time I used Rails API mode with Heroku, but it also would have a great fit on AWS Serveless Stack:
  Ruby (with no Rails) running on Lambda
  API Gateway
  RDS
  RDS Proxy (In case we have too many parallel connections on the database).
3. Because of time I won't integrate Swagger. I'll attach one Postman collection instead.
4. I won't implement Rubocop on this project, but I would in real project.
5. CI Is fully implemented with Github Actions and Heroku Webhooks

![VM and Specs](https://github.com/diegocharles/maybe-backend/workflows/VM%20and%20Specs/badge.svg?branch=development) <br />
![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/0c7bc986d0beba4ed663) <br />


BooksManager API application

### Rails Version
* Rails 6.1.0 (latest stable version)

### Ruby version
* Ruby 3.0.0 (latest stable version)

### System dependencies
* Docker and Docker Composer [recommended]

When not running with Docker:
  * PostgreSQL 11 or newer

### RUNNING WITH DOCKER ###
  1. `git clone git@github.com:diegocharles/books-manager-api.git`
  2. `cd books-manager-api`
  3. `docker-composer up`
  4. wait ....
  5. `docker-composer exec web bundle exec rails db:schema:load`
  6. `docker-composer exec web bundle exec rails db:migrate`
  7. `docker-composer exec web bundle exec rails db:seed`

  Finally, you can view it into your browser: https://localhost:3001

  * You can access the container shell by:
    `docker-composer exec web bash`
  * You can access the Rails Console via shell as demonstrated above or:
    `docker-composer exec web bundle exec rails c`
  * To run the Specs:
    `docker-composer exec web rspec`

  In case of troubles Just ping Diego Charles via email: diegocharles@me.com


### Configuration

#### Production Environment Variables

* Database Secrets
```bash
DATABASE_NAME: ''
DATABASE_ADAPTER: ''
DATABASE_ENCODING: ''
DATABASE_POOL:  ''
DATABASE_USERNAME: ''
DATABASE_PASSWORD: ''
```

* Application Secrets
```bash
SECRET_KEY_BASE: ''
```

#### Database creation and initialization
```bash
  rails db:create
  rails db:migrate
  rails db:migrate RAILS_ENV=test
  rails db:seed
```

### Code
* Use Rails 6 standards - RuboCop will enforce standards
* Rails Best Practices will enforce code quality

### Contributing
* Master should always be deployable and stable
* For each feature, task, or bug:
  * Branch from Master
  * Name your branch username/kind/feature-name
* Commits:
  * At minimum a commit should be done at the end of every working day even if not finished.
  * Commits should contain a comment that explains what was done.
  * Each ticket should have a corresponding branch that is prefixed with the authors name and has the story name.
  * Examples:
    * If Vik worked on feature, "User Login", I would have a branch "vik/features/feature-user-login,
    * If Anil worked on bug, "User Login Bug", it would be "anil/bug/bug-user-login".
* When a feature or bug is ready to merge you will make sure your branch is up to date with master, and then issue a pull request on Github.
  * Make sure all your code is commited for your branch
  * Change to master and do a git pull
  * Switch back to your branch and "git rebase master -i"
  * Squash all your WIP commits and make the feature a single commit.
  * Push your branch to Github
  * Create a pull request for your branch
* You should not merge your own pull requests into master unless it's an emergency.
* Another team member should review the pull request and do the merge if everything looks good.


### Testing (RSpec)
* Code must be tested using RSpec.
* Code will be checked with RuboCop.
* Code will be checked with Rails Best Practices
