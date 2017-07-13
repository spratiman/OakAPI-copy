class Api::V1::TermsController < ApplicationController
  before_action :doorkeeper_authorize!, :except => [:index, :show]
  before_action :authenticate_user!, :except => [:index, :show]

  # GET /courses/:course_id/terms
  def index
    @terms = Term.where(course_id: params[:course_id])
  end

  # GET /terms/:id
  def show
    @term = Term.find(params[:id])
  end

  # POST /terms/:id/enrol
  def enrol
    @enrolment = current_user.enrolments.create(term_id: params[:id])

    if @enrolment.save
      render json: @enrolment, status: :created
    else
      render json: { errors: @enrolment.errors }, status: :bad_request
    end
  end

  # DELETE /terms/:id/remove_enrol
  def remove_enrol
    @enrolment = current_user.enrolments.where(term_id: params[:id])

    (verify_user and verify_enrol) or return

    if @enrolment[0].delete
      head :no_content
    else
      render json: { errors: @enrolment.errors }, status: :bad_request
    end
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

  def verify_user
    if @enrolment.as_json[0]['user_id'] != current_user.id
      error_msg = { errors: 'You are not the user of this enrolment' }
      render json: error_msg, status: :unauthorized and return
    end

    return true
  end

  def verify_enrol
    if @enrolment.nil?
      return false
    end
    return true
  end
end