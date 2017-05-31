class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  # GET /courses/:course_id/comments
  def index
    @course = Course.find(params[:course_id])
    @comments = @course.comments
  end

  # POST /courses/:course_id/comments
  def create
    @course = Course.find(params[:course_id])
    @comment = @course.comments.new(params.permit(:body))
    @comment.user = current_user

    if @comment.save
      render "api/v1/comments/show", status: :created
    else
      render json: { errors: @comment.errors }, status: :bad_request
    end
  end

  # GET /comments/:id
  def show
    @comment = Comment.find(params[:id])
    @course = @comment.course
    @user = @comment.user
  end

  # PUT /comments/:id
  def update
    @comment = Comment.find(params[:id])
    @course = @comment.course
    @user = @comment.user

    if @comment.user == current_user
      if @comment.has_children?
        render json: { errors: 'You cannot edit this comment since it has replies' }, status: :unprocessable_entity
      elsif @comment.update_attributes(params.permit(:body))
        render "api/v1/comments/show", status: :ok
      else
        render json: { errors: 'You cannot edit this comment to have a empty body' }, status: :bad_request
      end
    else
      render json: { errors: 'You cannot edit this comment' }, status: :unauthorized
    end
  end

  # DELETE /comments/:id
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      begin
        @comment.destroy
        head :no_content
      rescue Ancestry::AncestryException => exc
        render json: { errors: 'You cannot delete this comment since it has replies' }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'You cannot delete this comment' }, status: :unauthorized
    end
  end

  # POST /comments/:id/reply
  def reply
    parent_comment = Comment.find(params[:id])
    @course = parent_comment.course
    @user = current_user
    @comment = Comment.new(body: params[:body], user: @user, course: @course, parent: parent_comment)

    if @comment.save
      render "api/v1/comments/show", status: :created
    else
      render json: { errors: @comment.errors }, status: :bad_request
    end
  end
  
end
