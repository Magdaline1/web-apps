# {{ METHOD }} {{ PATH}} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

Return a hello method
  Method: GET
  Path: /hello
  Query parameters: name

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```
When the param `name` is `Jane` 
=> Hello Jane

When the param `name` is `Josh`
=> Hello Josh
```

## 3. Write Examples

_Replace these with your own design._

```
# Request:

GET /hello?name=Jane

# Expected response:
Hello Jane

```

```
# Request:

GET /hello?name=Josh

# Expected response:
Hello Josh
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /hello" do
    it 'returns "hello Jane"' do
        response = get('/hello?name=Jane')

        expect(response.status).to be(200)
        expect(response.body).to eq ("Hello Jane")
    end

    it 'returns "Hello Josh"' do
      response = get('/hello?name=Josh')
      
      expect(response.status).to be(200)
      expect(response.body).to eq ("Hello Josh")
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.
