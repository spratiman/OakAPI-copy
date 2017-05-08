json.extract! rating, :id, :rating_type, :value
json.url course_rating_url(@course, rating, format: :json)
