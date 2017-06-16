json.success true
json.data do
  json.partial! "api/v1/courses/course", course: @course
  json.comments @course.comments do |comment|
    json.id comment.id
    json.body comment.body
    json.url comment_url(comment, format: :json)
  end
end