require 'rails_helper'

describe Api::V1::AuthTokensController do
  describe 'POST #create' do
    let!(:user) { create :user, email: 'blog@email.example' }

    context 'when success' do
      let(:params) { { email: 'blog@email.example', password: '111111' } }

      before { post :create, format: :json, params: params }

      specify do
        expect(json.to_json).to eq({
                                      'success': true,
                                      'auth_token': user.authentication_token
                                   }.to_json)
        expect(response).to have_http_status(201)
      end
    end

    context 'when failure' do
      let(:params) { { email: 'blog@email.example', password: '123456' } }

      before { post :create, format: :json, params: params }

      specify do
        expect(json.to_json).to eq({
                                      'error': { 'message': 'Not Authenticated' }
                                   }.to_json)
        expect(response).to have_http_status(401)
      end
    end
  end
end

