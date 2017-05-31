json.success true
json.data do
  json.partial! "api/v1/comments/comment", comment: @comment
  json.user_url user_url(@user, format: :json)
  json.replies @comment.children, partial: 'api/v1/comments/comment', as: :comment
end