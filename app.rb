require 'sinatra'
require 'pry'
require 'httparty'
require 'sinatra/activerecord'
require './config/environments'
require './models/game'
require './models/stat'
require './models/player'
require './models/team'
#SCRAPER
get '/scrape' do
  
end
#NO PATH
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
      example: '/games?week=4 OR /games?week=4,5,6 OR /games?week=all'
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
  @home_team = Team.find(@game.home_id)
  @away_team = Team.find(@game.away_id)
  @stats = @game.stats
  @touchdowns = @stats.where(touchdown: true)
  home_score = 0
  away_score = 0
  @touchdowns.each do |x|
    if x.player.team == @home_team
      home_score += 7
    elsif x.player.team == @away_team
      away_score += 7
    end
  end

  game_object = {
    id: @game.id,
    home: @game.home,
    home_score: home_score,
    away_score: away_score,
    away: @game.away,
    week: @game.week,
    gamecode: @game.gamecode,
    _link: "/games/#{@game.id}",
  }

  return {
    status: 200,
    results_count: 1,
    results: {
      game_data: game_object,
      game_stats: @stats
    }
  }.to_json
end

get '/players' do
  @all_players = Player.all
  @players_object = []
  if params['team'] == nil then
    return {
      status: '400',
      message: 'Please provide team parameter in query',
      example: '/players?team=4 OR /players?team=4,5,6 OR /players?team=all'
    }.to_json
  elsif params['team'] == 'all' then
    @all_players.each do |player|
      if player.position != nil
        @players_object << player
      end
    end
  else
    @all_players.each do |player|
      if player.position != nil && player.current_team == params['team']
        @players_object << player
      end
    end
  end
  return {
    status: 200,
    results_count: @players_object.length,
    results: @players_object
  }.to_json
end

get '/players/{id}' do
  @player = Player.find(params['id'])
  return {
    status: 200,
    results_count: 1,
    results: {
      player_data: @player,
      team_data: {
        id: @player.team.id,
        location: @player.team.location,
        name: @player.team.name,
        full_name: "#{@player.team.location} #{@player.team.name}",
        _link: "/teams/#{@player.team.id}"
      },
      player_stats: @player.stats
      }
  }.to_json
end

get '/teams' do
  @all_teams = Team.all
  @response_array = []
  if params['name'] == nil && params['location'] == nil then
    return {
      status: '400',
      message: 'Please provide team id in query, a name or location as a parameter',
      example: '/teams/12 OR /teams?name=Patriots OR /teams?location=Detriot OR /teams?name=all OR /teams?location=all'
    }.to_json
  elsif params['name'] == 'all' || params['location'] == 'all'then
    @all_teams.each do |team|
      team_object = {
        id: team.id,
        location: team.location,
        name: team.name,
        full_name: "#{team.location} #{team.name}",
        _link: "/teams/#{team.id}"
      }
      @response_array << team_object
    end
    return {
      status: 200,
      results_count: @response_array.length,
      results: @response_array
    }.to_json
  else
    if params['name'] != nil then
      @query_teams = Team.where(name: params['name'])
      @query_teams.each do |team|
        team_object = {
          id: team.id,
          location: team.location,
          name: team.name,
          full_name: "#{team.location} #{team.name}",
          _link: "/teams/#{team.id}"
        }
        @response_array << team_object
      end
    elsif params['location'] != nil then
      @query_teams = Team.where(location: params['location'])
      @query_teams.each do |team|
        team_object = {
          id: team.id,
          location: team.location,
          name: team.name,
          full_name: "#{team.location} #{team.name}",
          _link: "/teams/#{team.id}",
          team_players: Player.where(team_id: team.id)
        }
        @response_array << team_object
      end
    end
    return {
      status: 200,
      results_count: @response_array.length,
      results: @response_array
    }.to_json
  end
end

get '/teams/{id}' do
  @team = Team.find(params['id'])
  team_object = {
    id: @team.id,
    location: @team.location,
    name: @team.name,
    full_name: "#{@team.location} #{@team.name}",
    _link: "/teams/#{@team.id}",
    team_players: Player.where(team_id: @team.id)
  }
  return {
    status: 200,
    results_count: 1,
    results: team_object
  }.to_json
end
