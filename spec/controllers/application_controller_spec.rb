require 'rails_helper'

describe ApplicationController, type: :controller do
  describe 'Authenticable' do
    let(:user) { create(:user) }

    controller do
      def index
      end
    end

    describe '#authenticate_user' do
      context 'when the authentication token is valid' do
        it 'returns the valid user' do
          request.headers['Authorization'] = "Token token=#{user.authentication_token}"

          expect(controller.authenticate_user).to eq (user)  
        end
      end

      context 'when the authentication token is invalid' do
        it 'returns bad credentials error' do
          get :index # fake action call

          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    describe '#current_user' do
      context 'when the authentication token is valid' do
        it 'returns the current user' do
          request.headers['Authorization'] = "Token token=#{user.authentication_token}"

          expect(controller.current_user).to eq(user)
        end
      end

      context 'when the authentication token is invalid' do
        it 'returns nil' do
          expect(controller.current_user).to eq(nil)
        end
      end
    end
  end
end