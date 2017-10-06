class Api::V1::Author::BaseController < Api::V1::BaseController
  before_action :authenticate_user!

  private

  def authenticate_user!
    user = User.find_by(authentication_token: http_auth_token)

    if user.present?
      sign_in user, store: false
    else
      raise Exceptions::NotAuthorizedError
    end
  end

  def http_auth_token
    @http_auth_token ||= if request.headers['X-Auth-Token'].present?
                           request.headers['X-Auth-Token'].split(' ').last
                         end
  end
end
