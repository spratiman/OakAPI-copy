json.success true
json.data do
  json.partial! "api/v1/terms/term", term: @term
  json.lectures @term.lectures
  json.users @term.users do |user|
    json.id user.id
    json.name user.name
    json.url user_url(user, format: :json)
  end
end
