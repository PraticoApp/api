module Authenticable
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def authenticate_user
    authenticate_token || render_unauthorized
  end

  def current_user
    @current_user ||= authenticate_token
  end

  private

  def authenticate_token
    authenticate_with_http_token do |token|
      user = User.find_by(authentication_token: token)

      if user
        ActiveSupport::SecurityUtils.secure_compare(
          Digest::SHA256.hexdigest(token),
          Digest::SHA256.hexdigest(user.authentication_token)
        )

        return user
      end
    end
  end

  def render_unauthorized
    render json: { errors: 'Bad credentials' }, status: :unauthorized
  end
end
