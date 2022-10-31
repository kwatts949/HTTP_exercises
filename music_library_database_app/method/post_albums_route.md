POST /albums Route Design Recipe

1. Design the Route Signature
You'll need to include:

the HTTP method
the path
any query parameters (passed in the URL)
or body parameters (passed in the request body)

Methd: POST
Path: /albums
With body parameters:
title=Voyage
release_year=2022
artist_id=2

2. Design the Response


3. Write Examples
Replace these with your own design.

# Request:

POST /albums

With body parameters:
title=Voyage
release_year=2022
artist_id=2

# Expected response:

Expected response (200 OK)
(No content)

4. Encode as Tests Examples
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "POST /albums" do
    it 'returns 200 OK' do
      expect(response.status).to eq(200)
      # expect(response.body).to eq(expected_response)
    end

    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end
end
5. Implement the Route
Write the route and web server code to implement the route behaviour.