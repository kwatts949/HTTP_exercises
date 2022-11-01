require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  include Rack::Test::Methods
  let(:app) { Application.new }

  def reset_albums_table
    seed_sql = File.read('spec/seeds/albums_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_new_test' })
    connection.exec(seed_sql)
  end

  def reset_artists_table
    seed_sql = File.read('spec/seeds/artists_seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_new_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_artists_table
    reset_albums_table
  end

  context "GET /albums" do
    it 'returns a list of albums' do
      response = get("/albums")

      expect(response.status).to eq(200)
      expect(response.body).to include("<div> Title: Doolittle<br> Released: 1989</div><br>")
      expect(response.body).to include("<div> Title: Fodder on My Wings<br> Released: 1982</div><br>")
    end
  end

  context "GET /artists" do
    it 'returns the list of artists' do
      response = get('/artists')

      expected_response = ("Pixies, ABBA, Taylor Swift, Nina Simone")

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end
  end

  context "GET /artists/:id" do
    it 'returns info about album 1' do
      response = get('/albums/1')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Doolittle</h1>')
      expect(response.body).to include('Release year: 1989')
      expect(response.body).to include('Artist: Pixies')
    end
  end

  context "POST /albums" do
    it 'creates a new album' do
      response = post("/albums", title: "Voyage", release_year: '2022', artist_id: 2)

      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      response = get('/albums')
      expect(response.body).to include("Voyage")
    end
  end

  context "POST /artists" do
    it 'creates a new artist' do
      response = post('/artists', name: 'Wild Nothing', genre: 'Indie')

      expect(response.status).to eq(200)
      expect(response.body).to eq("")

      response = get('/artists')
      expect(response.body).to include("Wild Nothing")
    end
  end
end

