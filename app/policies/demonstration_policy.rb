class DemonstrationPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    true
    # record is the instance of the model passed to `authorize` in controller
    # user is the current_user
  end

  def destroy?
    true
  end
  # def create?
  #   true record.user == user
  # end
end
