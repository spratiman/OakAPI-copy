# Oak API

This is the API that Oak uses to manage data related to courses, comments, ratings, users, etc. The API follows RESTful ideology and returns all data in JSON format.

## API Endpoints

The API exposes the following RESTful endpoints:

| HTTP Verb | Endpoint                  | Functionality            |
|:---------:|:-------------------------:|:------------------------:|
| POST      | /auth                     | Login                    |
| POST      | /account                  | Create account           |
| GET       | /account                  | Show account             |
| PATCH     | /account                  | Update account           |
| DELETE    | /account                  | Delete account           |
| GET       | /users                    | List all users           |
| GET       | /users/:id                | Show a user              |
| GET       | /courses                  | List all courses*        |
| GET       | /courses/:id              | Show a course            |
| GET       | /courses/:id/comments     | List all course comments |
| POST      | /courses/:id/comments     | Add a course comment     |
| PATCH     | /courses/:id/comments/:id | Update a course comment  |
| DELETE    | /courses/:id/comments/:id | Delete a course comment  |
| GET       | /courses/:id/ratings      | List all course ratings  |
| POST      | /courses/:id/ratings      | Add a course rating      |
| PATCH     | /courses/:id/ratings/:id  | Update a course rating   |
| DELETE    | /courses/:id/ratings/:id  | Delete a course rating   |

> *optional url parameter _query_ can contain code, name, or description of course to look for

For endpoints which return significant amounts of data, the following url parameters are also available:

| Parameter       | Functionality                                 |
|:---------------:|:----------------------------------------------|
| ?order=asc      | Sorts the resulting data in ascending order.  |
| ?order=dec      | Sorts the resulting data in descending order. |
| ?limit=:num     | Gets the first :num entries of data.          |
| ?page=:num      | Gets the :num page of data.                   |
| ?per_page=:num  | Sets the number of entries per page to :num.  |