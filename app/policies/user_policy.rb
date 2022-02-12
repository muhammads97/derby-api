class UserPolicy < ApplicationPolicy

  def show?
    true
  end

  def update?
    true
  end

  def leave_team
    true
  end
end
