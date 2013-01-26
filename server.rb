#!/usr/bin/env ruby
require 'sinatra'

Dir["#{File.expand_path("../lib", __FILE__)}/*.rb"].each do |file|
  require file
end

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
