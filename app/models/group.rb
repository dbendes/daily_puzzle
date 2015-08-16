class Group < ActiveRecord::Base
    has_many :memberships
    has_many :users, through: :memberships

    def members
        self.users.length
    end
end