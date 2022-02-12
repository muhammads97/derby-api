class TeamRequestPolicy < ApplicationPolicy
  def index?
    user.team_id && user.id == user.team.captain_id
  end

  def show?
    record.team.captain_id == user.id
  end

  def update_status?
    record.team.captain_id == user.id 
  end

  def status_action?
    record == "accept" || record == "reject"
  end

  class Scope < Scope

    def resolve
      scope.find_by_team_id(user.team_id)
    end
    
  end

end