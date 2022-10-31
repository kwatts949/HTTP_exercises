require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  include Rack::Test::Methods
  let(:app) { Application.new }

  context "GET /names" do
    it "returns 200 OK with the right content" do
      response = get("/names")
      expect(response.status).to eq(200)
      expect(response.body).to eq("Julia, Mary, Karim")
    end
  end

  context "POST /sort-names" do
    it "returns 200 OK with the right content" do
      response = post("/sort-names", names: "Joe,Alice,Zoe,Julia,Kieran")
      expect(response.status).to eq(200)
      expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end
  end

  context "GET /hello" do
    it 'contains a h1 title' do
    response = get('/hello')

    expect(response.body).to include('<h1>Hello!</h1>')
    end
  end
end