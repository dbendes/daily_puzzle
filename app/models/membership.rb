class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  validates :group, uniqueness:  { scope: [:user] }
end
