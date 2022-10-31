# ** POST /sort-names Route Design Recipe**

## **1. Design the Route Signature**

You'll need to include:

- the HTTP method
- the path
- any query parameters (passed in the URL)
- or body parameters (passed in the request body)

Return a selection of names sorted into alphabetical order
Method: POST
Path: /sort-names
Query parameter: names

## **2. Design the Response**

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code.

names=Joe,Alice,Zoe,Julia,Kieran

response = Alice,Joe,Julia,Kieran,Zoe

## **3. Write Examples**


`# Request:

POST /sort-names?names=Joe,Alice,Zoe,Julia,Kieran

# Expected response:

Response for 200 OK`

Alice,Joe,Julia,Kieran,Zoe

## **4. Encode as Tests Examples**

`# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "POST /sort-names" do
    it 'returns 200 OK' do
      expect(response.status).to eq(200)
      # expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end

    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end
end`

## **5. Implement the Route**

Write the route and web server code to implement the route behaviour.