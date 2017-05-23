require 'sinatra'
require 'pry'
require 'sinatra/activerecord'
require './config/environments'
require './models/game'
require './models/stat'
require './models/player'

get '/' do
  return {
    status: '400',
    message: 'Invalid request, please use defined paths',
    example: '/games, /teams, /players, /stats'
  }.to_json
end
# ALL GAMES
get '/games' do
  @all_games = Game.all
  if params['week'] == nil then
    return {
      status: '400',
      message: 'Please provide week parameter in query',
      example: '/games?week=4 OR /games?week=4,5,6'
    }.to_json
  elsif params['week'] == 'all' then
    @query_week = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15']
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
# INDIVIDUAL GAME
get '/games/{id}' do
  game_id = params['id']
  @game = Game.find(game_id)
  stat_array = []
  if params["stats"] == "true" then
    @game_stats = Stat.where(gamecode: @game.gamecode)
    @game_stats.each do |stat|
      stat_array << stat.get_stat_object(stat.id)
    end
  else
    stat_array = {
      message: "To include stats, please set stats param to true",
      example: "/games/#{@game.id}?stats=true"
      }
  end

  game_object = {
    id: @game.id,
    home: @game.get_team_object(@game.home),
    away: @game.get_team_object(@game.away),
    week: @game.week,
    gamecode: @game.gamecode,
    _link: "/games/#{@game.id}",
    game_stats: stat_array
  }

  return {
    status: 200,
    results_count: 1,
    results: game_object
  }.to_json
end
