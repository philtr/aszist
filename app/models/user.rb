class User < ActiveRecord::Base
  has_many :tickets
  has_many :assigned_tickets, class_name: "Ticket", foreign_key: :agent_id
  has_many :comments

  after_initialize :set_default_role, :set_temporary_password

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  ROLES = %w( customer agent admin )

  def name
    if self.first_name or self.last_name
      return [self.first_name, self.last_name].join(" ").lstrip
    else
      return self.email
    end
  end

  def tickets_count
    tickets.actionable.count + assigned_tickets.actionable.count
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

  def self.agents
    where("role IN (?)", ["agent", "admin"])
  end

  def self.admins
    where(role: "admin")
  end

  def self.default_agent
    # TODO: Make this configurable in the app
    User.agents.first
  end

  protected

  def set_default_role
    self.role ||= ROLES[0]
  end

  def set_temporary_password
    # TODO: Send user their temporary password if this is still set after creation
    self.password = SecureRandom.base64(18) if encrypted_password.blank?
  end

end
