class User < ActiveRecord::Base
  has_many :tickets
  has_many :comments

  before_create :set_default_role

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me

  scope :agents, where("role = ? OR ?", "agent", "admin")
  scope :admins, where(:role => "admin")

  ROLES = %w[customer agent admin]

  def self.default_agent
    # TODO: Make this configurable in the app
    User.first
  end

  def name
    return [self.first_name, self.last_name].join(" ").to_s
  end

  def to_s
    if self.name.to_s.empty?
      return self.email
    else
      return self.name
    end
  end

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

private

  def set_default_role
    self.role = ROLES[0]
  end

end
