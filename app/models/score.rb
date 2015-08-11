class Score < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  validates :game, presence: true
  validates :user, presence: true
  validates :value, presence: :true
  validates :date, uniqueness:  { scope: [:user, :game] }


  def format_long
    game = self.game_id
    value = self.value
    #if game has a time format, format as time
    if game == 1
      mins = (value/60.0).floor
      secs = value%60
      mins.floor.round.to_s + " " + "minute".pluralize(mins) + " " + (secs).round(2).to_s + " " +  "second".pluralize(secs)
    # if game has a steps format, format as points
    elsif game ==2
      (value).round.to_s + " " + "step".pluralize(value)
    # if a game has a points format, format as points
    elsif game == 3
      (value.to_s) + " " + "points".pluralize(value)
    end
  end

  def format_short
    game = self.game_id
    value = self.value

    #if game has a time format, format as time
    if game == 1
      (value / 60).floor.to_s + ":" + value%60.to_s
    # if game has a steps format, format as points
    elsif game ==2
      value
    # if a game has a points format, format as points
    elsif game == 3
      value
    end
  end

end
