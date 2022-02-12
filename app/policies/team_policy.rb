class TeamPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.player?
  end

  def update?
    record.captain_id == user.id
  end

  class Scope < Scope

    def resolve
      scope.all
    end
    
  end

end