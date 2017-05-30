require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { create(:user) }
  let(:valid_session_params) do
    {
      session: {
        email: user.email,
        password: user.password
      }
    }
  end
  let(:invalid_session_params) do
    {
      session: {
        email: 'invalid@email.com',
        password: 'invalid'
      }
    }
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'returns http status ok' do
        post api_v1_login_path, params: valid_session_params

        expect(response).to have_http_status(:ok)
      end

      it 'renders the new user token' do
        post api_v1_login_path, params: valid_session_params

        user.reload
        json = JSON.parse(response.body)
        expect(json['token']).to eq(user.authentication_token)
      end

      it 'generates a new user token' do
        old_authentication_token = user.authentication_token

        post api_v1_login_path, params: valid_session_params

        user.reload
        expect(user.authentication_token).to_not eq(old_authentication_token)
      end
    end

    context 'with invalid params' do
      it 'returns http status unauthorized' do
        post api_v1_login_path, params: invalid_session_params

        expect(response).to have_http_status(:unauthorized)
      end

      it 'renders bad credentials error' do
        post api_v1_login_path, params: invalid_session_params

        json = JSON.parse(response.body)
        expect(json['errors']).to eq('Bad credentials')
      end
    end
  end

  describe 'DELETE destroy' do
    context 'with valid params' do
      it 'returns http status ok' do
        delete api_v1_logout_path, headers: { 'Authorization': "Token token=#{user.authentication_token}" }

        expect(response).to have_http_status(:ok)
      end

      it 'returns empty body' do
        delete api_v1_logout_path, headers: { 'Authorization': "Token token=#{user.authentication_token}" }

        expect(response.body).to eq('')
      end

      it 'generates a new user token' do
        old_authentication_token = user.authentication_token

        delete api_v1_logout_path, headers: { 'Authorization': "Token token=#{user.authentication_token}" }

        user.reload
        expect(user.authentication_token).to_not eq(old_authentication_token)
      end
    end

    context 'with invalid params' do
      it 'returns http status unauthorized' do
        delete api_v1_logout_path

        expect(response).to have_http_status(:unauthorized)
      end

      it 'renders bad credentials error' do
        delete api_v1_logout_path

        json = JSON.parse(response.body)
        expect(json['errors']).to eq('Bad credentials')
      end
    end
  end
end
