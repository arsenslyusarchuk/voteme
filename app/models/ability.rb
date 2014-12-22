class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :destroy, Poll do |poll|
      poll.user.id == user.id
    end

    can :stop, Poll do |poll|
      poll.user.id == user.id
    end
  end
end
