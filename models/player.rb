class Player < ActiveRecord::Base
  def get_player_object(size)
    @player = Player.find(self.id)
    if size == "full" then
      return {
        id: @player.id,
        first_name: @player.first_name,
        last_name: @player.last_name,
        full_name: @player.first_name + " " + @player.last_name,
        height: @player.height,
        weight: @player.weight,
        born: @player.born,
        years_pro: @player.years_pro,
        college: @player.college,
        position: @player.position,
        current_team: @player.current_team,
        number: @player.number,
        _image_link: @player.image,
        _link: "/players/#{@player.id}"
      }
    else
      return {
        id: @player.id,
        full_name: @player.first_name + " " + @player.last_name,
        position: @player.position,
        current_team: @player.current_team,
        number: @player.number,
        _image_link: @player.image,
        _link: "/players/#{@player.id}"
      }
    end

  end
end
