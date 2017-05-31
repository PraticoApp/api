module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_user, only: :create

      def create
        @user = User.new(user_params)

        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        current_user.active = false
        current_user.save

        head :ok
      end

      def update
        if current_user.update(user_params)
          render json: current_user, status: :ok
        else
          render json: current_user.errors, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(
          :first_name,
          :last_name,
          :email,
          :password,
          :cpf,
          :phone,
          :gender,
          :birth_date,
          address_attributes: address_params
        )
      end

      def address_params
        %i[
          id
          primary_address
          secondary_address
          number
          zip_code
          city
          state
          country
          latitude
          longitude
        ]
      end
    end
  end
end
