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

    def user_today(profile_id)
        self.scores.where(user_id: profile_id).where(date: Date.today)
    end

    def user_ever(profile_id)
        self.scores.where(user_id: profile_id)
    end

    def user_top_ever(number, profile_id)
        self.scores.where(user_id: profile_id).order(value: :asc).first(number)
    end

    def user_this_week(profile_id)
        self.scores.where(user_id: profile_id).where('created_at >= ?', 1.week.ago)
    end

    def user_alltime(profile_id)
        self.scores.where(user_id: profile_id)
    end

    def user_alltime_score(profile_id)
        total_score = 0.0
        count = 0.0
        self.user_alltime(profile_id).each do |score|
            total_score += score.value
            count += 1
        end
        value = (((100*total_score) / count) / 100).round(2)
        game = self.id
        #if game has a time format, format as time
        if game == 1 or game ==3
          mins = (value/60.0).floor
          secs = value%60
          mins.floor.round.to_s + " " + "minute".pluralize(mins) + " " + (secs).round(2).to_s + " " +  "second".pluralize(secs)
        # if game has a steps format, format as points
        elsif game ==2
            (value).to_s + " " + "step".pluralize(value)
        # if a game has a points format, format as points
        elsif game == 4
            (value.to_s) + " " + "points".pluralize(value)
        end

    end

    def user_this_week_score(profile_id)
        total_score = 0.0
        count = 0.0
        self.user_this_week(profile_id).each do |score|
            total_score += score.value
            count += 1
        end
        value = (((100*total_score) / count) / 100).round(2)
        game = self.id
        #if game has a time format, format as time
        if game == 1 or game == 3
          mins = (value/60.0).floor
          secs = value%60
          mins.floor.round.to_s + " " + "minute".pluralize(mins) + " " + (secs).round(2).to_s + " " +  "second".pluralize(secs)
        # if game has a steps format, format as points
        elsif game ==2
            (value).round.to_s + " " + "step".pluralize(value)
        # if a game has a points format, format as points
        elsif game == 4
            (value.to_s) + " " + "points".pluralize(value)
        end

    end

    def user_today_score(profile_id)
        value = self.user_today(profile_id).first.value
        game = self.id
        #if game has a time format, format as time
        if game == 1 or game == 3
          mins = (value/60.0).floor
          secs = value%60
          mins.floor.round.to_s + " " + "minute".pluralize(mins) + " " + (secs).round(2).to_s + " " +  "second".pluralize(secs)
        # if game has a steps format, format as points
        elsif game ==2
            (value).round.to_s + " " + "step".pluralize(value)
        # if a game has a points format, format as points
        elsif game == 4
            (value.to_s) + " " + "points".pluralize(value)
        end
    end


end
