# gifts_api_test
After cloning the repo:
### Install the gems

```
bundle install
```
## Setup the database

### Change database.yml to be able to connect to postgres locally.

```
Run rails db:create
Run rails db:migrate
```

### Start the server

```
Run rails s -p 3000
```

Create User record in order to get an authentication token.
On rails console: 

```
Run User.create(email: "john.doe@example.com", password: "test123")
```