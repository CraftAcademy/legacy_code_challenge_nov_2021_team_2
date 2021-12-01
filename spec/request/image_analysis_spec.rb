# frozen_string_literal: true

RSpec.describe Api::AnalysesController, type: :request do
  describe 'Image analysiss' do
    describe 'SAFE' do
      before do
        post '/api/analyses', params: { analysis: {
          resource: 'https://c.tadst.com/gfx/1200x630/sunrise-sunset-sun-calculator.jpg?1',
          category: :image
        } }
      end
      it {
        expect(response).to have_http_status 200
      }

      it 'is expected to be safe' do
        expect(JSON.parse(response.body)['results']['safe'].to_f > 0.9)
          .to be_truthy
      end
    end

    describe 'UNSAFE' do
      before do
        post '/api/analyses', params: { analysis: {
          resource: 'https://www.abc.net.au/cm/rimage/11076160-1x1-xlarge.jpg?v=2',
          category: :image
        } }
      end
      it {
        expect(response).to have_http_status 200
      }

      it 'is expected to be suggesstive' do
        expect(JSON.parse(response.body)['results']['suggestive'].to_f > 0.9)
          .to be_truthy
      end
    end
  end
end
