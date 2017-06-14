json.extract! course, :id, :code, :title, :department, :division, :level, :campus
json.url course_url(course, format: :json)
json.comments_url course_comments_url(course, format: :json)
json.terms_url course_terms_url(course, format: :json)
