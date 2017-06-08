class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :role, presence: true
  has_and_belongs_to_many :tickets

  paginates_per 5

  def admin?
    self.role == 'admin'
  end

  def agent?
    self.role == 'agent'
  end

  def customer?
    self.role == 'customer'
  end
end
