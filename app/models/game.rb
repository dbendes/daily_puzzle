class Game < ActiveRecord::Base
    has_one :instruction
    has_many :scores
    has_many :users, through: :scores
end
