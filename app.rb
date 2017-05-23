require 'sinatra'
require 'pry'
require 'sinatra/activerecord'
require './config/environments'
require './models/game'

get '/' do
  'Hello, World!'
end

get '/games' do
  @all_games = Game.all
  if params['week'] == nil then
    return {
      status: '400',
      message: 'Please provide week parameter in query',
      example: '/games?week=4 OR /games?week=4,5,6'
    }.to_json
  else
    @query_week = params['week'].split(',')
  end

  output_array = []
  @all_games.each do |game|
    @query_week.each do |week|
      if game.week == week
        output_array << {
          id: game.id,
          home: game.home,
          away: game.away,
          week: game.week,
          gamecode: game.gamecode,
          _link: "/games/#{game.id}"
        }
      end
    end
  end

  output_object = {
    status: 200,
    results_count: output_array.length,
    results: output_array
  }

  return output_object.to_json
end
