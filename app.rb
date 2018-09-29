require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/bookmark'

class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    #form - add bookmarks and view bookmarks
    erb :hello
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  post '/bookmarks' do
    string = "Not a real string"
    flash[:error] = string unless Bookmark.create(params[:title], params[:bookmark])
    redirect '/bookmarks'
  end

  get '/bookmarks/new' do
    erb :add_bookmark
  end

  delete '/bookmarks/:id' do
    p params
    Bookmark.delete(params[:id])
    redirect '/bookmarks'
  end

  get '/delete_bookmarks' do
    erb :delete_bookmark
  end

  post '/deleter' do
    Bookmark.delete(params["id"])
    redirect '/bookmarks'
  end

  run! if app_file == $0

end
