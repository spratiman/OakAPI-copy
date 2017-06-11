# OakAPI

[![Deploy to Docker Cloud](https://files.cloud.docker.com/images/deploy-to-dockercloud.svg)](https://cloud.docker.com/stack/deploy/?repo=https://github.com/uoftweb/OakAPI)

A RESTful API that Oak uses to manage data related to courses, comments, ratings, users, etc. The API returns all data in JSON format and uses HTTP verbs and status codes to communicate intent. This API is built on Ruby on Rails and makes use of [Devise](https://github.com/plataformatec/devise) and [devise_auth_token](https://github.com/lynndylanhurley/devise_token_auth) for user authentication. JSON templates are also generated using [Jbuilder](https://github.com/rails/jbuilder).

## Dependencies

This project makes use of [Docker](https://www.docker.com/community-edition) for the development environment to maintain consistency. 

## Installation

Clone the repository to your computer.

Make sure Docker is running. Open a console in the root of the project directory and enter:

```
docker-compose up
```

This will install all of the gems defined in the `Gemfile`, including Rails. At this point you could run `rails server` in the web container, but you will receive a bunch of errors because the database has not been generated yet.

### Generating the Database

To generate the database for development and testing environments, run these commands in your console:

```
docker-compose run web bundle exec rails db:setup
```

This will generate development and test databases, as well as run migrations.

### Populating the Database with Courses

To populate the database with courses from [Cobalt datasets](https://github.com/cobalt-uoft/datasets), run:

```
docker-compose run web bundle exec rake update_course
```

This may take some time, but when complete, your development database will be populated with courses from the most recent academic year.

### Creating a User

You may also want to create a user so that you can get an authentication token to test different routes. To do this, you will need to run a rails console:

```
docker-compose run web bundle exec rails c
```

You will need to create a new user with email and password using the create method on the User model:

```
User.create(name: 'John Smith', email: 'test@example.com', password: 'valid_password');
```

You can exit out of the Rails console by simply typing `exit`.

## Usage

To start the server:

```
docker-compose up
```

This will start a server on http://localhost:3000 under the development environment. You can interact with the API using curl if you prefer using the command line. However, it is recommended that you make use of a GUI application such as [Postman](https://www.getpostman.com/) or [Insomnia](https://insomnia.rest/). You will need to include the HTTP header `Accept: application/vnd.oak.v1` in order for any requests to work.

To run tests:

```
docker-compose run web bundle exec rails test
```

## API Endpoints

The API exposes the following RESTful endpoints:

| HTTP Verb | Endpoint                  | Functionality            |
|:---------:|:-------------------------:|:------------------------:|
| POST      | /auth                     | Create account           |
| GET       | /auth                     | Show account             |
| PUT       | /auth                     | Update account           |
| DELETE    | /auth                     | Delete account           |
| POST      | /auth/sign_in             | Login                    |
| DELETE    | /auth/sign_out            | Logout                   |
| GET       | /users                    | List all users           |
| GET       | /users/:id                | Show a user              |
| GET       | /courses                  | List all courses         |
| GET       | /courses/:id              | Show a course            |
| GET       | /courses/:id/comments     | List all course comments |
| POST      | /courses/:id/comments     | Add a course comment     |
| GET       | /comments/:id             | Show a course comment    |
| PUT       | /comments/:id             | Update a course comment  |
| DELETE    | /comments/:id             | Delete a course comment  |
| POST      | /comments/:id/reply       | Reply to a comment       |
| GET       | /courses/:id/ratings      | List all course ratings  |
| POST      | /courses/:id/ratings      | Add a course rating      |
| GET       | /ratings/:id              | Show a course rating     |
| PUT       | /ratings/:id              | Update a course rating   |

## Support

Please [open an issue](https://github.com/uoftweb/OakAPI/issues) for support.

## Contributing

Please contribute using by creating a separate branch from development as base or forking the repository. Add your commits and then [open a pull request](https://github.com/uoftweb/OakAPI/pulls).

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/uoftweb/OakAPI/blob/master/LICENSE) file for details.
