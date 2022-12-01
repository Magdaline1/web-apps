require "spec_helper"
require "rack/test"
require_relative '../../app'

def reset_albums_table
  seed_sql = File.read('spec/seeds/albums_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

def reset_artists_table
  seed_sql = File.read('spec/seeds/artists_seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_albums_table
    reset_artists_table
  end

  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }
  
  context "GET /albums" do
    it 'returns a html list of albums' do
      response = get('/albums')

      expect(response.status).to be(200)
      expect(response.body).to include('<p>Doolittle</p>')
      expect(response.body).to include('<p>Surfer Rosa</p>')
      expect(response.body).to include('<p>Waterloo</p>')
      expect(response.body).to include('<p>Super Trouper</p>')
      expect(response.body).to include('<p>Lover</p>')
      expect(response.body).to include('<p>Bossanova</p>')
      expect(response.body).to include('<p>Folklore</p>')
      expect(response.body).to include('<p>I Put a Spell on You</p>')
      expect(response.body).to include('<p>Baltimore</p>')
      expect(response.body).to include('<p>Here Comes the Sun</p>')
      expect(response.body).to include('<p>Fodder on My Wings</p>')
      expect(response.body).to include('<p>Ring Ring</p>')

    end
  end

  context "POST /albums" do
    it 'returns nothing' do
      post_response = post('/albums', title: "Voyage", release_year: 2022, artist_id: 2)
      expect(post_response.status).to be(200)

      #get_response = get('/albums')
      #expect(get_response.body).to eq "Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring, Voyage"
    end
  end

  context "GET /artists" do
    it 'returns a list of all artists' do
      response = get('/artists')

      expect(response.status).to be(200)
      expect(response.body).to eq ("Pixies, ABBA, Taylor Swift, Nina Simone")
    end
  end

  context "POST /artists" do
    it 'adds artists to the database' do
      post_response = post('/artists', name: 'Wild nothing', genre: 'Indie')
      expect(post_response.status).to be (200)

      get_response = get('/artists')

      expect(get_response.status).to be(200)
      expect(get_response.body).to eq ("Pixies, ABBA, Taylor Swift, Nina Simone, Wild nothing")
    end
  end

  context "GET /albums/:id" do
    it 'returns info about the relevant album' do
      response = get('/albums/1')

      expect(response.status).to be(200)
      expect(response.body).to include('<h1>Doolittle</h1>')
      expect(response.body).to include('Release year: 1989')
      expect(response.body).to include('Artist: Pixies')
    end
  end
  
end
