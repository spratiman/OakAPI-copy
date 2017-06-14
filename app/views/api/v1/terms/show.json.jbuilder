json.success true
json.data do
  json.partial! "api/v1/terms/term", term: @term
end
