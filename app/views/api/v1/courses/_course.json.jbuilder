json.extract! course, :id, :code, :title, :description, :exclusions, :prerequisites, :breadths
json.url course_url(course, format: :json)
json.comments_url course_comments_url(course, format: :json)
json.ratings_url course_ratings_url(course, format: :json)