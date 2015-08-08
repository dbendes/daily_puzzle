class Game < ActiveRecord::Base
    has_one :instruction
    has_many :scores
    has_many :users, through: :scores
    
    def self.top3
        scores.order(value: :desc).first(3)
    end
    
    def self.top5
        scores.order(value: :desc).first(5)
    end
    
    
end
