
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect "/articles"
  end

  # render index page
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  # render new view
  get '/articles/new' do
    @article = Article.new
    erb :new
  end

  # create/post a new article then redirect to that new article based on ID
  post '/articles' do
    @article = Article.create(params)
    redirect "/articles/#{ @article.id }"
  end

  # show the article with a specific id
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  # edit by rendering the edit form
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  # patch/update by finding the instance of that model to udpate
  patch '/articles/:id' do
    @article = Article.find(params[:id])
    # @article.title = params[:title]
    # @article.content = params[:content]
    # @article.save
    # @article.update(params[:article])
    @article.update(params[:article])
    redirect "/articles/#{ @article.id }"
  end

  # deletes an article from the database
  delete '/articles/:id' do
    Article.destroy(params[:id])
    redirect "/articles"
  end


end
