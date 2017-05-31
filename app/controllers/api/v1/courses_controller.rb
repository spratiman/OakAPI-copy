class Api::V1::CoursesController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  # GET /courses
  def index
    @courses = Course.limit(10)
  end

  # GET /courses/:id
  def show
    @course = Course.find(params[:id])
  end
end