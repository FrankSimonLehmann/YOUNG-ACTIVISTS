class DemonstrationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all # If users can see all restaurants
      # scope.where(user: user) # If users can only see their restaurants
      # scope.where("name LIKE 't%'") # If users can only see restaurants starting with `t`
      # ...
    end
  end

  def show?
    true
    # record is the instance of the model passed to `authorize` in controller
    # user is the current_user
  end

  def new?
    true
  end

  def create?
    true
  end

#   def edit?
#     true
#   end

#   def update?
#     true
#   end

#   def destroy?
#     true
#   end
end
