# OakAPI

[![Deploy to Docker Cloud](https://files.cloud.docker.com/images/deploy-to-dockercloud.svg)](https://cloud.docker.com/stack/deploy/?repo=https://github.com/uoftweb/OakAPI)

A RESTful API that Oak uses to manage data related to courses, comments, ratings, users, etc. The API returns all data in JSON format and uses HTTP verbs and status codes to communicate intent. This API is built on Ruby on Rails and makes use of [Devise](https://github.com/plataformatec/devise) and [devise_auth_token](https://github.com/lynndylanhurley/devise_token_auth) for user authentication. JSON templates are also generated using [Jbuilder](https://github.com/rails/jbuilder).

## Dependencies

This project makes use of [Docker](https://www.docker.com/community-edition) for the development environment to maintain consistency. 

## Installation

Clone the repository to your computer.

Make sure Docker is running. Open a console in the root of the project directory and enter:

```
docker-compose build
```

This will download and build the required images to run the API for development. **WARNING: This step takes quite a while depending on your internet connection, so feel free to take this time to grab a coffee or read through the rest of this document.** If you make a change to the Dockerfiles or docker-compose.yml, you will have to run this command again to rebuild the image, but depending on your changes, subsequent builds will be much faster due to caching. At this point you could try to run `docker-compose up`, which starts all the required services, but you will receive a bunch of errors because the database has not been generated yet.

### Generating the Database

To generate the database for development and testing environments, run this commands in your console:

```
docker-compose run web bundle exec rails db:setup
```

This will generate development and test databases, as well as run migrations. You only have to do this once.

### Populating the Database with Courses

To populate the database with courses from [Cobalt datasets](https://github.com/cobalt-uoft/datasets), run:

```
docker-compose run web bundle exec rake app:update_courses
```

This may take some time, but when it completes, your development database will be populated with courses from the most recent academic year.

### Creating a User

You may also want to create a user so that you can get an authentication token to test different routes. To do this, you will need to run a rails console:

```
docker-compose run web bundle exec rails c
```

You will need to create a new user with email and password using the create method on the User model:

```
User.create(name: 'John Smith', nickname: 'John', email: 'test@example.com', password: 'valid_password')
```

You can exit out of the Rails console by simply typing `exit`.

## Usage

To start the required containers for the first time:

```
docker-compose up
```

This will start a server on http://localhost:3000 under the development environment. You can interact with the API using curl if you prefer using the command line. However, it is recommended that you make use of a GUI application such as [Postman](https://www.getpostman.com/) or [Insomnia](https://insomnia.rest/). You will need to include the HTTP header `Accept: application/vnd.oak.v1` in order for any requests to work.

To run tests in a running container:

```
docker-compose exec web bundle exec rails test
```

To stop the containers:

```
docker-compose stop
```

To start up a container:

```
docker-compose start
```

**NOTE: This command is different from `docker-compose up` because it only starts existing containers, whereas the `up` command creates AND starts _new_ containers**

To list running containers:

```
docker-compose ps
```

To stop and **remove** the containers:

```
docker-compose down
```

## API Endpoints

Exposed endpoints are visible by visiting the root path (ie. `localhost:3000`), which redirects to the Swagger documentation.

## Support

Please [open an issue](https://github.com/uoftweb/OakAPI/issues) for support.

## Contributing

Please contribute using by creating a separate branch from development as base or forking the repository. Add your commits and then [open a pull request](https://github.com/uoftweb/OakAPI/pulls).

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/uoftweb/OakAPI/blob/master/LICENSE) file for details.
