class Api::V1::BaseController < ActionController::Base
  respond_to :json

  rescue_from Exceptions::NotAuthenticatedError, with: :user_not_authenticated
  rescue_from Exceptions::NotAuthorizedError, with: :user_not_authorized

  private

  def render_error(text, status_code=422)
    render json: { error: { message: text } },
           status: status_code
  end

  def user_not_authenticated
    render_error 'Not Authenticated', 401
  end

  def user_not_authorized
    render_error 'Not Authorized', 401
  end
end
