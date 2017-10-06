require 'rails_helper'

describe Api::V1::AuthTokensController, type: :request do
  describe 'POST #create' do
    let!(:user)  { create :user, email: 'blog@email.example' }

    before { post '/api/v1/auth_tokens', params: params, headers: json_request_headers }

    context 'when success' do
      let(:params) { { email: 'blog@email.example', password: '111111' }.to_json }

      specify do
        expect(response.body).to eq({
                                       success: true,
                                       auth_token: user.authentication_token
                                    }.to_json)
        expect(response).to have_http_status(201)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'when failure' do
      let(:params) { { email: 'blog@email.example', password: '123456' }.to_json }

      specify do
        expect(response.body).to eq({
                                       error: { message: 'Not Authenticated' }
                                    }.to_json)
        expect(response).to have_http_status(401)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end

