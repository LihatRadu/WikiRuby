require 'wikipedia'
require 'sinatra'
require_relative 'wikipedia_tui'

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

get '/api/search' do
  content_type :json
  query = params[:query]
  if query
    result = WikipediaHelper.fetch_page(query)
    if result
      { title: result[:title], content: result[:content] }.to_json
    else
      { error: "Page not found" }.to_json
    end
  else
    { error: "Query parameter 'query' is required" }.to_json
  end
end

if ARGV.include?('--terminal')
  puts "Welcome to WikiRuby!"
  print "Search..."
  query = gets.chomp

  result = WikipediaHelper.fetch_page(query)

  if result
    puts "\nTitle: #{result[:title]}\n"
    puts "\nText: #{result[:text]}\n"
  else
    puts "Page not found."
  end
end
