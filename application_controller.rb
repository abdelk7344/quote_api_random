require 'dotenv/load'
require 'bundler'
require 'net/http'
require 'json'
require 'ConnectSDK'


Bundler.require

require_relative 'models/model.rb'

class ApplicationController < Sinatra::Base

  get '/' do
    @final= get_quote
    @img= search_image(@final["topic"])
    erb :index
  end
  
end
