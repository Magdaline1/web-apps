require 'spec_helper'
require 'rack/test'
require_relative '../../app'

describe Application do
    include Rack::Test::Methods # This is so we can use rack-test helper methods.
    let(:app) { Application.new } # We need to declare the `app` value by instantiating the Application class so our tests work.

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
end