require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader


    get '/' do
      return "Hello"
    end

    get '/hello' do
      return erb(:index)
    end

    #get '/hello' do
     #   name = params[:name]
      #  return "Hello #{name}"
    #end

    post '/submit' do
      name = params[:name]
      message = params[:message]
      return "Thanks #{name}, you sent this message: #{message}"
    end

    get '/names' do
      name_1 = params[:name_1]
      name_2 = params[:name_2]
      name_3 = params[:name_3]
      return "#{name_1}, #{name_2}, #{name_3}"
    end

    post '/sort-names' do
      names = params[:names]
      sorted_names = names.split(",")
      return sorted_names.sort.join(", ")
    end

  end
end
