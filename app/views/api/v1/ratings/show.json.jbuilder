json.success true
json.data do
	json.partial! "api/v1/ratings/rating", rating: @rating
	json.user_url user_url(@user, format: :json)
end