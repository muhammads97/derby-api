class UserRequestPolicy < ApplicationPolicy
  def index?
    user.player?
  end

  def show?
    user.player? && record.player_id == user.id
  end

  def create?
    user.player?
  end

  def update_status?
    record.player_id == user.id 
  end

  def status_action?
    record == "join"
  end

  def destroy?
    record.player_id == user.id
  end

  class Scope < Scope

    def resolve
      scope.find_by_player_id(user.id)
    end
    
  end

end