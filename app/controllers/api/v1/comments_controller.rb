class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  # GET /courses/:course_id/comments
  def index
    @course = Course.find(params[:course_id])
    @comments = @course.comments
  end

  # GET /courses/:course_id/comments/:comment_id
  def show
    @course = Course.find(params[:course_id])
    @comment = @course.comments.find(params[:id])
    @user = @comment.user
  end

end
