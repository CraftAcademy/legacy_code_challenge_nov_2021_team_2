# frozen_string_literal: true

RSpec.describe Api::AnalysesController, type: :request do
  describe 'Text analysis' do
    before do
      post '/api/analyses', params: {
        analysis: { resource: 'This is awesome',
                    category: :text }
      }
    end
    it 'responds with an text analysis' do
      expect(response.status).to eq 200
    end
  end
end
