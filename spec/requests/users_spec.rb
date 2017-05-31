require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:valid_user_params) do
    attributes_for(:user)
  end

  let(:invalid_user_params) do
    attributes_for(:invalid_user)
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new user' do
        expect do
          post api_v1_users_path, params: { user: valid_user_params }
        end.to change(User, :count).by(1)
      end

      it 'returns http status created' do
        post api_v1_users_path, params: { user: valid_user_params }

        expect(response).to have_http_status(:created)
      end

      it 'returns the created user' do
        post api_v1_users_path, params: { user: valid_user_params }

        json = JSON.parse(response.body)
        expect(json['first_name']).to eq(valid_user_params[:first_name])
        expect(json['last_name']).to eq(valid_user_params[:last_name])
        expect(json['email']).to eq(valid_user_params[:email])
        expect(json['cpf']).to eq(valid_user_params[:cpf])
        expect(json['phone']).to eq(valid_user_params[:phone])
        expect(json['gender']).to eq(valid_user_params[:gender])
      end
    end

    context 'with invalid params' do
      it 'returns http status unprocessable entity' do
        post api_v1_users_path, params: { user: invalid_user_params }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the user errors' do
        post api_v1_users_path, params: { user: invalid_user_params }

        json = JSON.parse(response.body)
        expect(json['password']).to eq(["can't be blank"])
        expect(json['first_name']).to eq(["can't be blank"])
        expect(json['cpf']).to eq(["can't be blank", 'is the wrong length (should be 11 characters)'])
        expect(json['email']).to eq(["can't be blank"])
        expect(json['phone']).to eq(["can't be blank"])
        expect(json['gender']).to eq(["can't be blank"])
        expect(json['birth_date']).to eq(["can't be blank"])
      end
    end
  end

  describe 'DELETE destroy' do
    let(:user) { create(:user, active: true) }

    context 'with valid params' do
      it 'returns http status ok' do
        delete api_v1_user_path(user.id),
               headers: { Authorization: "Token token=#{user.authentication_token}" }

        expect(response).to have_http_status(:ok)
      end

      it 'returns empty body' do
        delete api_v1_user_path(user.id),
               headers: { Authorization: "Token token=#{user.authentication_token}" }

        expect(response.body).to eq('')
      end

      it 'sets the current user as inactive' do
        delete api_v1_user_path(user.id),
               headers: { Authorization: "Token token=#{user.authentication_token}" }

        user.reload
        expect(user.active).to eq(false)
      end
    end

    context 'with invalid params' do
      it 'returns http status unauthorized' do
        delete api_v1_user_path(user.id)

        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns bad credentials error' do
        delete api_v1_user_path(user.id)

        json = JSON.parse(response.body)
        expect(json['errors']).to eq('Bad credentials')
      end

      it 'does not set the user as inactive' do
        delete api_v1_user_path(user.id)

        expect(user.active).to eq(true)
      end
    end
  end

  describe 'PUT/PATCH update' do
    let(:user) { create(:user) }

    let(:new_user_params) do
      attributes_for(:user)
    end

    context 'with valid params' do
      it 'updates the requested user' do
        patch api_v1_user_path(user.id),
              params: { user: new_user_params },
              headers: { Authorization: "Token token=#{user.authentication_token}" }

        user.reload
        expect(user.email).to eq(new_user_params[:email])
      end

      it 'returns http status ok' do
        patch api_v1_user_path(user.id),
              params: { user: new_user_params },
              headers: { Authorization: "Token token=#{user.authentication_token}" }
      end

      it 'returns the updated user' do
        patch api_v1_user_path(user.id),
              params: { user: new_user_params },
              headers: { Authorization: "Token token=#{user.authentication_token}" }
      end
    end

    context 'with invalid params' do
      it 'returns http status unprocessable entity' do
        patch api_v1_user_path(user.id),
              params: { user: invalid_user_params },
              headers: { Authorization: "Token token=#{user.authentication_token}" }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the user errors' do
        patch api_v1_user_path(user.id),
              params: { user: invalid_user_params },
              headers: { Authorization: "Token token=#{user.authentication_token}" }

        json = JSON.parse(response.body)
        expect(json['password']).to eq(["can't be blank"])
        expect(json['first_name']).to eq(["can't be blank"])
        expect(json['cpf']).to eq(["can't be blank", 'is the wrong length (should be 11 characters)'])
        expect(json['email']).to eq(["can't be blank"])
        expect(json['phone']).to eq(["can't be blank"])
        expect(json['gender']).to eq(["can't be blank"])
        expect(json['birth_date']).to eq(["can't be blank"])
      end

      it 'does not update the user' do
        expect do
          patch api_v1_user_path(user.id),
                params: { user: invalid_user_params },
                headers: { Authorization: "Token token=#{user.authentication_token}" }
        end.not_to change {
          [
            user.first_name,
            user.last_name,
            user.email,
            user.cpf,
            user.phone,
            user.gender,
            user.birth_date
          ]
        }
      end
    end
  end
end
