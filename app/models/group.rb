class Group < ActiveRecord::Base
    has_many :memberships
    has_many :users, through: :memberships
    has_many :scores, through: :users
    has_many :group_invites
    validates :name, uniqueness: :true


    def members
        self.users.where(memberships: {role: [2,0]}).where.not(first: '').length
    end

    def top_alltime(number, game_id)
        self.scores.where(game_id: game_id).order(value: :asc).first(number)
    end


    def top_today(number, game_id)
        self.scores.where(game_id: game_id).where(date: Date.today).order(value: :asc).first(number)
    end

    def self.search(search)
        where('lower(name) LIKE ?', "%#{search.downcase}%")
    end
end