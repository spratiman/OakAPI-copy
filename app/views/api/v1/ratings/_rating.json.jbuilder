json.extract! rating, :id, :rating_type, :value
json.url rating_url(@course, rating, format: :json)
