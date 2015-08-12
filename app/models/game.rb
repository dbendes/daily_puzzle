class Game < ActiveRecord::Base
    has_one :instruction
    has_many :scores
    has_many :users, through: :scores

    def top3_alltime
        self.scores.order(value: :asc).first(3)
    end

    def top5_alltime
        self.scores.order(value: :asc).first(5)
    end

    def top3_today
        self.scores.where(date: Date.today).order(value: :asc).first(3)
    end

    def top5_today
        self.scores.where(date: Date.today).order(value: :asc).first(5)
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
        total_score / count
    end

    def user_this_week_score
        total_score = 0.0
        count = 0.0
        self.user_this_week.each do |score|
            total_score += score.value
            count += 1
        end
        total_score / count
    end

    def user_today_score
        self.user_today.first.value
    end

end
