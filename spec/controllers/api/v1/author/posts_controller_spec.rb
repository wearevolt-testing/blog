require 'rails_helper'

describe Api::V1::Author::PostsController, type: :request do
  describe 'POST #create' do
    let!(:user) { create :user, email: 'blog@email.example' }
    let(:auth_token) { { 'X-Auth-Token': user.authentication_token } }

    before { post '/api/v1/posts', params: params, headers: json_request_headers.merge!(auth_token) }

    context 'when success' do
      context 'with published_at' do
        let(:params) { { title: 'Title', body: 'Body', published_at: Time.now.change(usec: 0) }.to_json }

        specify do
          expect(json).to eq({
                                id: Post.last.id,
                                title: 'Title',
                                body: 'Body',
                                published_at: Time.parse(Time.now.to_s),
                                author_nickname: user.nickname
                             }.as_json)
          expect(response).to have_http_status(201)
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'when published_at is nil' do
        let(:params) { { title: 'Title', body: 'Body', published_at: '' }.to_json }

        specify do
          expect(json['published_at'].to_time.change(usec: 0)).to eq(Time.parse(Time.now.to_s))
          expect(response).to have_http_status(201)
          expect(response.content_type).to eq('application/json')
        end
      end
    end

    context 'when failure' do
      let(:params) { { title: '', body: '', published_at: '' }.to_json }

      specify do
        expect(json).to eq({
                              errors: ['Body can\'t be blank', 'Title can\'t be blank']
                           }.as_json)
        expect(response).to have_http_status(406)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end

