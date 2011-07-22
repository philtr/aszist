class User < ActiveRecord::Base
  has_many :tickets

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  def to_s
    if(self.first_name || self.last_name)
      return [self.first_name, self.last_name].join(" ")
    else
      return self.email
    end
  end

end
