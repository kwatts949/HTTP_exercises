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
      expect(response.body).to include("<div><a href='/albums/1'>Doolittle</a></div>")
      expect(response.body).to include("<div><a href='/albums/6'>Lover</a></div>")
    end
  end

  context "GET /artists" do
    it 'returns the list of artists' do
      response = get('/artists')

      expect(response.status).to eq(200)
      expect(response.body).to include("<div><a href='/artists/1'>Pixies</a></div>")
      expect(response.body).to include("<div><a href='/artists/4'>Nina Simone</a></div>")
    end
  end

   context "GET /albums/new" do
    it 'returns an html form to create a new album' do
      response = get('/albums/new')

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/albums">')
      expect(response.body).to include('input type="text" name="title"')
    end
  end

  context 'GET /artists/new' do
    it 'returns an html form to create a new artist' do
      response = get("/artists/new")

      expect(response.status).to eq(200)
      expect(response.body).to include('<form method="POST" action="/artists">')
      expect(response.body).to include('input type="text" name="name"')
    end
  end

  context "GET /album/:id" do
    it 'returns info about album 1' do
      response = get('/albums/1')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Doolittle</h1>')
      expect(response.body).to include('Release year: 1989')
      expect(response.body).to include('Artist: Pixies')
    end
  end

  context "GET /artists/:id" do
    it 'returns info about artist 1' do
      response = get('/artists/1')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Pixies</h1>')
      expect(response.body).to include('<p>Genre: Rock</p>')
    end
  end

  context "POST /artists" do
    it 'creates an artist and returns a confirmation page' do
      response = post('/artists', name: "my_artist")

      expect(response.status).to eq (200)
      expect(response.body).to include('<h1>Artist saved: my_artist</h1>')
    end
  end

  context "POST /albums" do
    it 'creates the album and returns a confirmation page' do
      response = post('/albums', title: "my_album")

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Album saved: my_album</h1>')
    end
  end
end

