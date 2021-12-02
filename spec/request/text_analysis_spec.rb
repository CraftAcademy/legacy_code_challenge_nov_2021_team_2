# frozen_string_literal: true

RSpec.describe Api::AnalysesController, type: :request do
  describe 'Successfully' do
    before do
      post '/api/analyses',
           params: {
             analysis: {
               resource: 'This is awesome',
               category: :text,
             },
           }
    end
    it 'responds with an text analysis' do
      expect(response.status).to eq 200
    end
  end

  describe 'Unsuccessfully' do
    describe 'with both params missing' do
      before { post '/api/analyses', params: {} }

      it 'is expected to respond with status 422' do
        expect(response.status).to eq 422
      end

      it 'is expected to return error message' do
        expect(
          response_json['message'],
        ).to eq 'Missing category and resource params'
      end
    end
    describe 'with category param missing' do
      before do
        post '/api/analyses',
             params: {
               analysis: {
                 resource: 'This is awesome',
               },
             }
      end

      it 'is expected to respond with status 422' do
        expect(response.status).to eq 422
      end

      it 'is expected to return error message' do
        expect(response_json['message']).to eq 'Missing category param'
      end
    end

    describe 'with resource param missing' do
      before { post '/api/analyses', params: { analysis: { category: :text } } }

      it 'is expected to respond with status 422' do
        expect(response.status).to eq 422
      end

      it 'is expected to return error message' do
        expect(response_json['message']).to eq 'Missing resource param'
      end
    end
  end
end
