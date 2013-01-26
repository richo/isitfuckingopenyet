#!/usr/bin/env ruby
require 'sinatra'

def load_all_in(path)
  Dir["#{File.expand_path("../lib/#{path}", __FILE__)}/*.rb"].each do |file|
    require file
  end
end

load_all_in("")
load_all_in("engines")
load_all_in("controllers")

class IsItOpen < Sintra::Base

  get '/' do
    erb :index
  end

  get '/search' do
    erb :search
  end

  post '/search' do
    results = SearchController.new(params).search
    erb :"search/results", :locals => {:results => results}
  end

end
