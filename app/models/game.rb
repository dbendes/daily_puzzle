class Game < ActiveRecord::Base
    has_one :instruction
    has_many :scores
    has_many :users, through: :scores

    def top_alltime(number)
        self.scores.order(value: :asc).first(number)
    end


    def top_today(number)
        self.scores.where(date: Date.today).order(value: :asc).first(number)
    end

    def scores_today
        self.scores.where(date: Date.today)
    end

    def user_today
        self.scores.where(user_id: User.current.id).where(date: Date.today)
    end

    def user_ever
        self.scores.where(user_id: User.current.id)
    end

    def user_this_week
        self.scores.where(user_id: User.current.id).where(date: 1.week.ago.beginning_of_week..1.week.ago.end_of_week)
    end

    def user_alltime
        self.scores.where(user_id: User.current.id)
    end

    def user_alltime_score
        total_score = 0.0
        count = 0.0
        self.user_alltime.each do |score|
            total_score += score.value
            count += 1
        end
        value = total_score / count
        game = self.id
        #if game has a time format, format as time
        if game == 1
          mins = (value/60.0).floor
          secs = value%60
          mins.floor.round.to_s + " " + "minute".pluralize(mins) + " " + (secs).round(2).to_s + " " +  "second".pluralize(secs)
        # if game has a steps format, format as points
        elsif game ==2
            (value).to_s + " " + "step".pluralize(value)
        # if a game has a points format, format as points
        elsif game == 3
            (value.to_s) + " " + "points".pluralize(value)
        end

    end

    def user_this_week_score
        total_score = 0.0
        count = 0.0
        self.user_this_week.each do |score|
            total_score += score.value
            count += 1
        end
        value = total_score / count
        game = self.id
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

    def user_today_score
        value = self.user_today.first.value
        game = self.id
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


end
