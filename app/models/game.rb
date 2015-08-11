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

    def users_today
        self.joins(:users, :scores).where(date: Date.today)
    end


end
