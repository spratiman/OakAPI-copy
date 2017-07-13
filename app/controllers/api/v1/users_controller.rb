class Api::V1::UsersController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :authenticate_user!

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/:id
  def show
    @user = User.find(params[:id])
  end

  # GET /users/:id/enrolments
  def enrolments
    user = User.find(params[:id])
    @enrolment = user.enrolments

    render json: @enrolment
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
