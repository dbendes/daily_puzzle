class Membership < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  validates :group, uniqueness:  { scope: [:user] }

  after_create :send_admin_email

  def send_admin_email
    if self.role == 1
      UserMailer.request_to_join_group_email(self).deliver
    end
  end


end
