json.extract! comment, :id, :body
json.num_replies comment.children.length
json.url comment_url(comment, format: :json)
