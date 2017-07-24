class Api::V1::CommentsController < Api::V1::BaseController
  before_action :doorkeeper_authorize!, :except => [:index, :show]

  # GET /courses/:course_id/comments
  def index
    course = Course.find(params[:course_id])
    @comments = course.comments
  end

  # POST /courses/:course_id/comments
  def create
    course = Course.find(params[:course_id])
    @comment = course.comments.new(comment_params)
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
  end

  # PUT /comments/:id
  def update
    @comment = Comment.find(params[:id])
    
    (verify_user and verify_no_replies) or return    

    if @comment.update_attributes(comment_params)
      render "api/v1/comments/show", status: :ok
    else
      error_msg = { errors: 'You cannot edit this comment to have a empty body' }
      render json: error_msg, status: :bad_request
    end
  end

  # DELETE /comments/:id
  def destroy
    @comment = Comment.find(params[:id])

    (verify_user and verify_no_replies) or return

    @comment.destroy
    head :no_content
  end

  # POST /comments/:id/reply
  def reply
    parent_comment = Comment.find(params[:id])
    @comment = Comment.new(body: params[:body], user: current_user, course: parent_comment.course, parent: parent_comment)

    if @comment.save
      render "api/v1/comments/show", status: :created
    else
      render json: { errors: @comment.errors }, status: :bad_request
    end
  end

private

  def comment_params
    params.permit(:body)
  end

  def verify_user
    if @comment.user != current_user
      error_msg = { errors: 'You are not the author of this comment' }
      render json: error_msg, status: :unauthorized and return
    end

    return true
  end

  def verify_no_replies
    if @comment.has_children?
      error_msg = { errors: 'You cannot edit this comment since it has replies' }
      render json: error_msg, status: :unprocessable_entity and return
    end

    return true
  end
end
