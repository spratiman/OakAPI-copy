class Api::V1::UsersController < ApplicationController
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
end
