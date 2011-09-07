class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here.
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
    user ||= User.new
    can :manage, Ticket do |ticket|
      ticket.agent_id == user.id or user.role? :admin
    end
    cannot :update_status, Ticket
    can [:create, :read, :update], User, :id => user.id
    if user.role? :agent
      can :manage, Ticket, :group => { :id => Ticket.where(:agent_id => user.id).collect{ |t| t.id } }
      can :update_status, Ticket
    end
    if user.role? :admin
      can :manage, :all
    end
  end
end
