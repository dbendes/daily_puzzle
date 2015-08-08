class Game < ActiveRecord::Base
    has_one :instruction
    has_many :scores
    has_many :users, through: :scores
    
    def top3
        self.scores.order(value: :desc).first(3)
    end
    
    def top5
        self.scores.order(value: :desc).first(5)
    end
    
    
end
