require 'spec_helper'
require 'rack/test'
require_relative '../../app'

describe Application do
    include Rack::Test::Methods # This is so we can use rack-test helper methods.
    let(:app) { Application.new } # We need to declare the `app` value by instantiating the Application class so our tests work.

    context 'GET /' do
        it 'returns 200 OK' do
            response = get('/')

            expect(response.status).to be(200)
            expect(response.body).to eq ("Hello")
        end

        it 'inserts a name as a parameter' do
            response = get('/hello', name: 'Jeff')

            expect(response.status).to be(200)
            expect(response.body).to eq ("Hello Jeff")
        end

        it 'sends a post request with parameters' do
            response = post('/submit', name: 'Jeff', message: 'hi')

            expect(response.status).to be(200)
            expect(response.body).to eq ("Thanks Jeff, you sent this message: hi")
        end
    end
end