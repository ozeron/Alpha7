class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin
      can :manage, :all
    else
      can [:read], :all
      can [:new], Survey
      can [:create], Survey unless user.id.nil?
      can [:update, :destroy], Survey do |survey|
        survey.try(:user) == user
      end
    end
  end
end
