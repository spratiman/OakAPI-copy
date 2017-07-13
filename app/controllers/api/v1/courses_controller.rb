class Api::V1::CoursesController < ApplicationController
  before_action :doorkeeper_authorize!, :except => [:index, :show]
  before_action :authenticate_user!, :except => [:index, :show]

  # GET /courses
  def index
    @courses = Course.all
  end

  # GET /courses/:id
  def show
    @course = Course.find(params[:id])
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

end