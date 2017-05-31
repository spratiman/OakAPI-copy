class Api::V1::RatingsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

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

  # POST /courses/:course_id/ratings
  def create
    @course = Course.find(params[:course_id])
    @rating = @course.ratings.new(params.permit(:value, :rating_type))
    @rating.user = current_user

    if @rating.save
      render json: @rating, status: 201
    else
      render json: { errors: @rating.errors }, status: 400
    end
  end

  # PUT /courses/:course_id/ratings/:rating_id
  def update
    @course = Course.find(params[:course_id])
    @rating = @course.ratings.find(params[:id])

    if @rating.user == current_user
      if @rating.update_attributes(params.permit(:value, :rating_type))
        render json: @rating, status: 201
      else
        render json: { errors: @rating.errors }, status: 400
      end
    else
      render json: { errors: 'You can not edit this rating' }, status: 401
    end
  end
end
