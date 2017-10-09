require 'rails_helper'

describe Api::V1::Author::BaseController, type: :request do
  let(:user) { create :user, email: 'blog@email.example' }
  let!(:auth_token) { { 'X-Auth-Token': '' } }

  describe 'Authenticate process' do
    before { post '/api/v1/comments', headers: json_request_headers.merge!(auth_token) }

    it 'when auth token is nil' do
      expect(response.body).to eq({
                                     error: { message: 'Not Authenticated' }
                                  }.to_json)
    end
  end
end
