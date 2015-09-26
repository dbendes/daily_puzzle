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

  has_attached_file :avatar,
    :styles => { :medium => "200x200>", :thumb => "100x100#" },
    :url  => ":s3_domain_url",
    :default_url => "gravatar31.jpg",
    :path => "public/avatars/:id/:style_:basename.:extension",
    :storage => :fog,
    :fog_credentials => {
        provider: 'AWS',
        aws_access_key_id: ENV["AWS_ACCESS_KEY"],
        aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    },
    fog_directory: ENV["FOG_DIRECTORY"]
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

 after_create :add_to_groups

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

  def add_to_groups
    invites = GroupInvite.where(email: self.email)
    if invites
                invites.each do |f|
                    f.group.users << self
                    f.destroy
                end
    end
  end

end
