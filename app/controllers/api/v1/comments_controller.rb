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

  # POST /courses/:course_id/comments
  def create
    @course = Course.find(params[:course_id])
    @comment = @course.comments.new(params.permit(:body))
    @comment.user = current_user

    if @comment.save
      render json: @comment, status: 201
    else
      render json: { errors: @comment.errors }, status: 400
    end
  end

  # PUT /courses/:course_id/comments/:comment_id
  def update
    @course = Course.find(params[:course_id])
    @comment = @course.comments.find(params[:id])

    if @comment.user == current_user
      if @comment.update_attributes(params.permit(:body))
        render json: @comment, status: 201
      else
        render json: { errors: 'You can not edit this comment to have a empty body' }, status: 400
      end
    else
      render json: { errors: 'You can not edit this comment' }, status: 401
    end
  end
end
