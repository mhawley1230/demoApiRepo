class Stat < ActiveRecord::Base
  def get_stat_object(input)
    @stat = Stat.find(input)
    return {
      id: @stat.id,
      play_type: @stat.play_type,
      yards: @stat.yards,
      direction: @stat.direction,
      was_complete: @stat.complete,
      was_touchdown: @stat.touchdown,
      was_intercepted: @stat.intercepted,
      _player_link: "/players/#{@stat.player_id}",
      _link: "/stats/#{@stat.id}"
    }
  end
end
