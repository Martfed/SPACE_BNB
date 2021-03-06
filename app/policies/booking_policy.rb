class BookingPolicy < ApplicationPolicy

  def show?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    true
  end

  def update?
    true
  end

  def destroy?
    record.user == user
  end

  def accept?
    true
  end

  def reject?
    true
  end
end
