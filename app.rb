require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  get '/' do
    #form - add bookmarks and view bookmarks
    erb :hello
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  get '/add_bookmarks' do
    erb :add_bookmark
  end

  post '/adder' do
    string = "Not a real string"
    flash[:error] = string unless Bookmark.create(params[:title], params[:bookmark])
    redirect '/bookmarks'
  end

  get '/delete_bookmarks' do
    erb :delete_bookmark
  end

  post '/deleter' do
    Bookmark.delete(params[:url])
    redirect '/bookmarks'
  end

  run! if app_file == $0

end
