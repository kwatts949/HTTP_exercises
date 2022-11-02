require 'sinatra/base'
require "sinatra/reloader"

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  post '/hello' do
    @name = (params[:name])
    if @name.match(/^[a-zA-Z]+$/)
      return erb(:hello)
    else
      return erb(:error)
    end
  end
end
