json.extract! comment, :id, :body
json.url course_comment_url(@course, comment, format: :json)
