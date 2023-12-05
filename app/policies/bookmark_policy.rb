class BookmarkPolicy < ApplicationPolicy
  class Scope < Scope
  end

  def create?
    true
  end
end
