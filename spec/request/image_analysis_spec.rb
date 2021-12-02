# frozen_string_literal: true

RSpec.describe Api::AnalysesController, type: :request do
  describe 'Image analysiss' do
    describe 'SAFE' do
      before do
        post '/api/analyses', params: { analysis: {
          resource: 'https://c.tadst.com/gfx/1200x630/sunrise-sunset-sun-calculator.jpg',
          category: :image
        } }
      end

      it {
        expect(response).to have_http_status 200
      }

      it 'is expected to respond with high safe' do
        expect(response_json['results']['safe'].to_f > 0.9)
          .to be_truthy
      end
    end

    describe 'UNSAFE' do
      describe 'suggestive content' do
        before do
          post '/api/analyses', params: { analysis: {
            resource: 'https://www.abc.net.au/cm/rimage/11076160-1x1-xlarge.jpg',
            category: :image
          } }
        end

        it {
          expect(response).to have_http_status 200
        }

        it 'is expected to respond with high suggestive score' do
          expect(response_json['results']['suggestive'].to_f > 0.9)
            .to be_truthy
        end
      end

      describe 'cartoon gore content' do
        before do
          post '/api/analyses', params: { analysis: {
            resource: 'https://preview.redd.it/08nbtvhwhtez.png?width=960&crop=smart&auto=webp&s=871ccf9733198c69416561a1d23bed68f9c1eca7',
            category: :image
          } }
        end

        it {
          expect(response).to have_http_status 200
        }

        it 'is expected to respond with low gore score' do
          expect(response_json['results']['gore'].to_f < 0.1)
            .to be_truthy
        end

        it 'is expected to respond with high safe score' do
          expect(response_json['results']['safe'].to_f > 0.9)
            .to be_truthy
        end
      end
      
      describe 'suggestive text' do
        before do
          post '/api/analyses', params: { analysis: {
            resource: 'https://image.spreadshirtmedia.net/image-server/v1/mp/products/T1459A839MPA4459PT28D16949164FS6299/views/1,width=1200,height=630,appearanceId=839,backgroundColor=F2F2F2/fuck-you-you-fuckin-fuck-klistermaerke.jpg',
            category: :image
          } }
        end

        it {
          expect(response).to have_http_status 200
        }

        it 'is expected to respond with high suggestive score' do
          expect(response_json['results']['suggestive'].to_f > 0.9)
            .to be_truthy
        end
      end

      # https://images.unsplash.com/photo-1572648414902-be106c6c826e?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bXVyZGVyfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60
      describe 'gore content' do
        before do
          post '/api/analyses', params: { analysis: {
            resource: 'https://images.unsplash.com/photo-1572648414902-be106c6c826e?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8bXVyZGVyfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
            category: :image
          } }
        end

        it {
          expect(response).to have_http_status 200
        }

        it 'is expected to respond with high gore score' do 
          expect(response_json['results']['gore'].to_f > 0.9)
            .to be_truthy
        end
      end
    end
  end
end
