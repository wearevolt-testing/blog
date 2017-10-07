require 'rails_helper'

describe Api::V1::Author::CommentsController, type: :request do
  let(:user) { create :user, email: 'blog@email.example' }
  let!(:auth_token) { { 'X-Auth-Token': user.authentication_token } }

  describe 'POST #create' do
    before { post '/api/v1/comments', params: params, headers: json_request_headers.merge!(auth_token) }

    context 'when success' do
      let(:post_new) { create :post }
      let(:params) { { comment: { body: 'Body' }, post_id: post_new.id }.to_json }

      specify do
        expect(response.body).to eq({
                                       data: 'Comment was succesfully created'
                                    }.to_json)
        expect(response).to have_http_status(201)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'when failure' do
      context 'when body is nil' do
        let(:post_new) { create :post }
        let(:params) { { comment: { body: '' }, post_id: post_new.id }.to_json }

        specify do
          expect(response.body).to eq({
                                         errors: ['Body can\'t be blank']
                                      }.to_json)
          expect(response).to have_http_status(406)
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'when post_id is nil' do
        let(:params) { { comment: { body: 'Body' }, post_id: '' }.to_json }

        specify do
          expect(response.body).to eq({
                                         error: { message: 'Post not found' }
                                      }.to_json)
          expect(response).to have_http_status(406)
          expect(response.content_type).to eq('application/json')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    before { delete '/api/v1/comments', params: params, headers: json_request_headers.merge!(auth_token) }

    context 'when success' do
      let(:comment) { create :comment, author: user }
      let(:params) { { comment_id: comment.id } }

      specify do
        expect(response.body).to eq({
                                       data: 'Comment was succesfully destroyed'
                                    }.to_json)
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'when failure' do
      let(:params) { { comment_id: '' } }

      specify do
        expect(response.body).to eq({
                                       error: { message: 'Comment not found' }
                                    }.to_json)
        expect(response).to have_http_status(422)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
