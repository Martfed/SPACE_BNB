class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def edit?
    true
  end

  def update?
    true
  end

  def mybookings?
    true
  end

  def myships?
    true
  end

  def myshipsbookings?
    true
  end

  def addareview?
    true
  end
end
