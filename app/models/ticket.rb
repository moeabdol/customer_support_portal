class Ticket < ApplicationRecord
  validates :content, presence: true
  validates :status, presence: true

  has_and_belongs_to_many :users
end
