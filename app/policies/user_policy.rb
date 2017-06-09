class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin? or (user.agent? and user == record) or
      (user.agent? and record.customer?) or (user.customer? and user == record)
  end

  def update?
    (user.admin? and not record.admin?) and
      (not record.admin? or user == record)
  end

  def destroy?
    (user.admin? and not record.admin?) and
      (not record.admin? or user == record)
  end

  def agents?
    user.admin?
  end

  def customers?
    user.admin? or user.agent?
  end
end
