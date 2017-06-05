class Game < ActiveRecord::Base
  has_many :stats

  def get_team_object(input)
    return {
      id: "FILL_IN_LATER",
      team_name: input,
      _link: "/teams/FILL_IN_LATER"
    }
  end
end
