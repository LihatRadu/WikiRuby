require 'wikipedia'
require 'sinatra'

page = Wikipedia.find("Iron Maiden")

puts(page.title, page.text)

get "/" do
  erb :index
end

get "/search" do
  @query = params[:query]

  if @query
    @page = Wikipedia.find(@query)
    if @page
      erb :search
    else
      redirect '/'
    end
  end
end
