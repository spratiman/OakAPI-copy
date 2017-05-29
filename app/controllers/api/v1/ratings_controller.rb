class Api::V1::RatingsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  # GET /courses/:course_id/ratings
  def index
    @course = Course.find(params[:course_id])
    @ratings = @course.ratings
  end

  # GET /ratings/:id
  def show
    @rating = Rating.find(params[:id])
    @course = @rating.course
    @user = @rating.user
  end

end
