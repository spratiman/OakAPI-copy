class Api::V1::RatingsController < ApplicationController
  before_action :authenticate_user!

  # GET /courses/:course_id/ratings
  def index
    @course = Course.find(params[:course_id])
    @ratings = @course.ratings
  end

  # GET /courses/:course_id/ratings/:rating_id
  def show
    @course = Course.find(params[:course_id])
    @rating = @course.ratings.find(params[:id])
    @user = @rating.user
  end

end
