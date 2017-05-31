module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate_user, only: :create

      def create
        @user = User.find_by(email: session_params[:email])

        if @user && @user.authenticate(session_params[:password])
          @user.regenerate_authentication_token

          render json: { token: @user.authentication_token }, status: :ok
        else
          render json: { errors: 'Bad credentials' }, status: :unauthorized
        end
      end

      def destroy
        current_user.regenerate_authentication_token

        head :ok
      end

      private

      def session_params
        params.require(:session).permit(:email, :password)
      end
    end
  end
end
