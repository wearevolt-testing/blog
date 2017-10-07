require 'rails_helper'

describe Api::V1::Author::PostsController, type: :request do
  let(:user) { create :user, email: 'blog@email.example' }
  let!(:auth_token) { { 'X-Auth-Token': user.authentication_token } }

  describe 'POST #create' do
    before { post '/api/v1/posts', params: params, headers: json_request_headers.merge!(auth_token) }

    context 'when success' do
      context 'with published_at' do
        let(:params) { { title: 'Title', body: 'Body', published_at: Time.now.change(usec: 0) }.to_json }

        specify do
          expect(response.body).to eq({
                                          id: Post.last.id,
                                          title: 'Title',
                                          body: 'Body',
                                          published_at: Time.parse(Time.now.to_s),
                                          author_nickname: user.nickname
                                      }.to_json)
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
        expect(response.body).to eq({
                                       errors: ['Body can\'t be blank', 'Title can\'t be blank']
                                    }.to_json)
        expect(response).to have_http_status(406)
        expect(response.content_type).to eq('application/json')
      end
    end
  end


  describe 'GET #show' do
    let(:post) { create :post, author: user }
    let(:params) { { post_id: post.id } }

    context 'when success' do
      before { get "/api/v1/posts/#{post.id}", headers: json_request_headers.merge!(auth_token) }

      specify do
        expect(response.body).to eq(Api::V1::PostSerializer.new(post).to_json)

        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'when failure' do
      before { get "/api/v1/posts/not_id", headers: json_request_headers.merge!(auth_token) }

      specify do
        expect(response.body).to eq({
                                       error: { message: 'Post not found' }
                                    }.to_json)

        expect(response).to have_http_status(406)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'GET #index' do
    let!(:posts) { create_list :post, 2, author: user }

    before { get '/api/v1/posts', params: params, headers: json_request_headers.merge!(auth_token) }

    context 'when success' do
      let(:params) { { page: 1, per_page: 2 } }

      specify do
        expect(response.body).to_not eq(
                                          { test: 'test' }.to_json
                                       )

        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'when failure' do
      let(:params) { { page: 1, per_page: '' } }

      specify do
        expect(response.body).to eq({
                                       error: { message: 'Incorrect parameters' }
                                    }.to_json)

        expect(response).to have_http_status(406)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end

