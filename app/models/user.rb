class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :games, through: :scores
  has_many :scores, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  has_many :invitations, :class_name => self.to_s, :as => :invited_by

 # after_create :send_welcome_email

  def full_name
    self.first + " " + self.last
  end

  def short_name
    self.first + " " + self.last.first + "."
  end


  def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user] = user
  end

  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

end
