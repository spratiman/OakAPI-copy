class Api::V1::TermsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  # GET /courses/:course_id/terms
  def index
    @terms = Term.where(course_id: params[:course_id])
  end

  # GET /terms/:id
  def show
    @term = Term.find(params[:id])
  end
end