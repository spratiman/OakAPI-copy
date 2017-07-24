class Api::V1::CoursesController < Api::V1::BaseController
  before_action :doorkeeper_authorize!, :except => [:index, :show]

  # GET /courses
  def index
    @courses = Course.all
  end

  # GET /courses/:id
  def show
    @course = Course.find(params[:id])
  end

end