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

        #it 'inserts a name as a parameter' do
        #    response = get('/hello', name: 'Jeff')

        #    expect(response.status).to be(200)
        #    expect(response.body).to eq ("Hello Jeff")
        #end

        it 'sends a post request with parameters' do
            response = post('/submit', name: 'Jeff', message: 'hi')

            expect(response.status).to be(200)
            expect(response.body).to eq ("Thanks Jeff, you sent this message: hi")
        end
    end


    context "GET /names" do
        it 'returns "Julia, Mary, Karim"' do
            response = get('/names?name_1=Julia&name_2=Mary&name_3=Karim')
    
            expect(response.status).to be(200)
            expect(response.body).to eq ("Julia, Mary, Karim")
        end
    end

    context "POST /sort-names" do
        it "returns a sorted list of names" do
            response = post("/sort-names", names: "Joe,Alice,Zoe,Julia,Kieran")

            expect(response.status).to eq (200)
            expect(response.body).to eq "Alice, Joe, Julia, Kieran, Zoe"
        end
    end

    context "GET /hello" do
        it 'returns the html index' do
          response = get('/hello')
      
          expect(response.body).to include('<h1>Hello!</h1>')
        end
        
    end
end