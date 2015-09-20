class Group < ActiveRecord::Base
    has_many :memberships
    has_many :users, through: :memberships
    has_many :scores, through: :users
    has_many :group_invites
    validates :name, uniqueness: :true


    def members
        self.users.where(memberships: {role: [2,0]}).length
    end

    def top_alltime(number, game_id)
        self.scores.where(game_id: game_id).order(value: :asc).first(number)
    end


    def top_today(number, game_id)
        self.scores.where(game_id: game_id).where(date: Date.today).order(value: :asc).first(number)
    end

    def self.search(search)
      if search
        where('lower(name) LIKE ?', "%#{search.downcase}%")
      else
        Group.all
      end
    end
end