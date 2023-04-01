class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_error


  private

  def render_not_found_error
    render json: {errors: "#{controller_name.classify} not found"}, status: 422
  end

  def render_invalid_error invalid
    render json: {errors: invalid.record.errors.full_messages}, status: 422
  end

end
