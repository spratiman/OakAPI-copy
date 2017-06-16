json.success true
json.data @courses do |course|
  json.extract! course, :id, :code, :title
  json.url course_url(course, format: :json)
  json.comments_url course_comments_url(course, format: :json)
end
