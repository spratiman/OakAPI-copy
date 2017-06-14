json.extract! term, :id, :term, :description, :exclusions,
  :prerequisites, :breadths
json.url term_url(term, format: :json)
json.lectures_url term_lectures_url(term, format: :json)
# json.ratings_url term_ratings_url(term, format: :json)