json.success true
json.data do
  json.partial! "api/v1/users/user", user: @user
  json.enrolments do
    json.enrolments_made @user.enrolments.count
    json.url enrolments_user_url(@user, format: :json)
  end
  json.comments_made @user.comments.count
  json.comments @user.comments do |comment|
    json.id comment.id
    json.body comment.body
    json.url comment_url(comment, format: :json)
  end
end