class Api::V1::BaseController < ActionController::API
  clear_respond_to
  respond_to :json

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: errors_json(e.message), status: :not_found
  end

private

  def errors_json(messages)
    { status: "error", errors: [*messages] }
  end

end