class TeamInvitationPolicy < ApplicationPolicy
  def index?
    user.team_id && user.team.captain_id == user.id
  end
  
  def show?
    record.team.captain_id == user.id 
  end

  def create?
    user.team_id && user.team.captain_id == user.id
  end

  def destroy?
    user.team_id && user.team.captain_id == user.id
  end

  class Scope < Scope
    def resolve
      scope.find_by_team_id(user.team_id)
    end
  end
end