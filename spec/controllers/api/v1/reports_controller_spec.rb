require 'rails_helper'

describe Api::V1::ReportsController, type: :request do
  describe 'POST #by_author' do
    before { post '/api/v1/reports/by_author', params: params, headers: json_request_headers }

    context 'when success' do
      let(:params) { { start_date: 5.years.ago, end_date: 2.years.ago, email: 'example@example.co' }.to_json }

      specify do
        expect(response.body).to eq({
                                       message: 'Report generation started'
                                    }.to_json)
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'when failure' do
      context 'when params are incorrect' do
        let(:params) { { incorrect_start_date: 5.years.ago, incorrect_end_date: 'Invalid_date', incorrect_email: 'example@example.co' }.to_json }

        specify do
          expect(response.body).to eq({
                                         error: { message: 'The specified parameters are incorrect' }
                                      }.to_json)
          expect(response).to have_http_status(422)
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'when date is invalid' do
        let(:params) { { start_date: 5.years.ago, end_date: 'Invalid_date', email: 'example@example.co' }.to_json }

        specify do
          expect(response.body).to eq({
                                         error: { message: 'Date is invalid' }
                                      }.to_json)
          expect(response).to have_http_status(422)
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'when period of dates is invalid' do
        let(:params) { { start_date: 2.years.ago, end_date: 2.years.ago, email: 'example@example.co' }.to_json }

        specify do
          expect(response.body).to eq({
                                         error: { message: 'Period of dates is invalid' }
                                      }.to_json)
          expect(response).to have_http_status(422)
          expect(response.content_type).to eq('application/json')
        end
      end
    end
  end
end
