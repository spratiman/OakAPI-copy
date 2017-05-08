class Api::V1::CoursesController < ApplicationController
  before_action :authenticate_user!

  # GET /courses
  def index
    @courses = Course.limit(10)
  end

  # GET /courses/1
  def show
    @course = Course.find(params[:id])
  end

end