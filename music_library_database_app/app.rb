# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums' do
    album_repository = AlbumRepository.new
    @albums = album_repository.all
    album_list = []
    @albums.each do |album|
      album_list << album.title
    end
    return erb(:albums)
  end

  post '/albums' do
    album_repository = AlbumRepository.new
    album = Album.new
    album.title = params[:title]
    album.release_year = params[:release_year]
    album.artist_id = params[:artist_id]
    album_repository.create(album)
  end

  get "/artists" do
    artist_repository = ArtistRepository.new
    artists = artist_repository.all
    artist_list = []
    artists.each do |artist|
      artist_list << artist.name
    end
    artist_list.join(", ")
  end

  post "/artists" do
    artist_repository = ArtistRepository.new
    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]
    artist_repository.create(artist)
  end

  get "/albums/:id" do
    album_repo = AlbumRepository.new
    artist_repo = ArtistRepository.new


    @album = album_repo.find(params[:id])
    @artist = artist_repo.find(@album.artist_id)

    return erb(:album)
  end
end