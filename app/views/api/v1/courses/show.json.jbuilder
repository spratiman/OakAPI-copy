json.success true
json.data do
  json.partial! "api/v1/courses/course", course: @course
  json.users @course.users do |user|
    json.id user.id
    json.name user.name
    json.email user.email
    json.url user_url(user, format: :json)
  end
  json.comments @course.comments do |comment|
    json.id comment.id
    json.body comment.body
    json.url course_comment_url(comment, format: :json)
  end
end