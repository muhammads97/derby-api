class UserInvitationPolicy < ApplicationPolicy
  def index?
    user.player?
  end

  def show?
    record.player_id == user.id
  end

  def update_status?
    record.player_id == user.id
  end

  def status_action?
    record == "accept" || record == "reject" || record == "join"
  end

  class Scope < Scope
    def resolve
      scope.find_by_player_id(user.id)
    end
  end
end