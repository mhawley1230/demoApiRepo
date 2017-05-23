require 'sinatra'
require 'sinatra/ActiveRecord'
require './config/environments'

get '/' do
  'Hello, World!'
end
