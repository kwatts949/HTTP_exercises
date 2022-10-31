require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base 
  configure :development do
    register Sinatra::Reloader
  end

  get '/hello' do
     return erb(:index)
  end

  get '/names' do
     return "Julia, Mary, Karim"
  end

  post '/submit' do
    name = params[:name]
    message = params[:message]
    return "Thanks #{name} you sent this message: #{message}"
  end

  post '/sort-names' do
    names = params[:names]
    return names.split(",").sort.join(",")
  end
end

# Postman request
# GET
# http://localhost:9292/hello?name=Maria

# POST
# http://localhost:9292/submit?name=Kay&message='Hello World'