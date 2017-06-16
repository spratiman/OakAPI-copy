json.success true
json.data @terms do |term|
  json.partial! term
  json.url term_url(term, format: :json)
  json.course_url course_url(term.course_id, format: :json)
  json.ratings_url term_ratings_url(term, format: :json)
end
