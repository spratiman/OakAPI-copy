class Api::V1::RatingsController < ApplicationController
  before_action :doorkeeper_authorize!, :except => [:index, :show]
  before_action :authenticate_user!, :except => [:index, :show]

  # GET /terms/:term_id/ratings
  def index
    term = Term.find(params[:term_id])
    @ratings = term.ratings
  end

  # GET /ratings/:id
  def show
    @rating = Rating.find(params[:id])
  end

  # POST /terms/:term_id/ratings
  def create
    term = Term.find(params[:term_id])
    @rating = term.ratings.new(params.permit(:value, :rating_type))
    @rating.user = current_user

    if @rating.save
      render json: @rating, status: :created
    else
      render json: { errors: @rating.errors }, status: :bad_request
    end
  end

  # PUT /ratings/:id
  def update
    @rating = Rating.find(params[:id])

    verify_user or return

    if @rating.update_attributes(params.permit(:value, :rating_type))
      render json: @rating, status: :ok
    else
      render json: { errors: @rating.errors }, status: :bad_request
    end
  end

private

  def authenticate_user!
    if doorkeeper_token
      Thread.current[:current_user] = User.find(doorkeeper_token.resource_owner_id)
    end

    return if current_user

    render json: { errors: ['User is not authenticated!'] }, status: :unauthorized
  end

  def current_user
    Thread.current[:current_user]
  end

  def verify_user
    if @rating.user != current_user
      error_msg = { errors: 'You are not the author of this rating' }
      render json: error_msg, status: :unauthorized and return
    end

    return true
  end
end
