json.success true
json.data do
  json.partial! "api/v1/users/user", user: @user
  json.courses @user.courses do |course|
    json.id course.id
    json.code course.code
    json.title course.title
    json.url course_url(course, format: :json)
  end
  json.comments @user.comments do |comment|
    json.id comment.id
    json.body comment.body
    json.url comment_url(comment, format: :json)
  end
end