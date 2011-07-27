class User < ActiveRecord::Base
  has_many :tickets
  has_many :comments

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me

  ROLES = %w[customer agent admin]

  def self.default_agent
    # TODO: Make this configurable in the app
    User.first
  end

  def to_s
    if(self.first_name || self.last_name)
      return [self.first_name, self.last_name].join(" ")
    else
      return self.email
    end
  end

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

end
