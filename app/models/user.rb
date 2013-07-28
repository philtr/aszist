class User < ActiveRecord::Base
  has_many :tickets
  has_many :comments

  before_create :set_default_role

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  ROLES = %w( customer agent admin )

  def self.agents
    where("role = ? OR role = ?", "agent", "admin")
  end

  def self.admins
    where(role: "admin")
  end

  def self.default_agent
    # TODO: Make this configurable in the app
    User.agents.first
  end

  def name
    if self.first_name or self.last_name
      return [self.first_name, self.last_name].join(" ").lstrip
    else
      return self.email
    end
  end

  def to_s
    if self.name.blank?
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
