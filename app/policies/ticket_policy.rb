class TicketPolicy < ApplicationPolicy
  def index?
    !user.customer?
  end

  def create?
    user.customer?
  end

  def show?
    user.admin? or user.agent? or ticket.users.include?(user)
  end

  def update?
    user.admin? or (user.customer? and ticket.users.include?(user) and
      ticket.status == 'unresolved')
  end

  def destroy?
    user.admin? or (user.customer? and ticket.users.include?(user) and
      ticket.status == 'unresolved')
  end

  def resolve?
    user.agent? and ticket.status == 'unresolved'
  end

  private

  def ticket
    record
  end
end
