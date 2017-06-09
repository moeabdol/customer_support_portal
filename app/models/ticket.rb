class Ticket < ApplicationRecord
  validates :content, presence: true
  validates :status, presence: true
  has_and_belongs_to_many :users

  paginates_per 5

  def self.search(search, page)
    if search
      where('content LIKE ?', "%#{search}%").order('created_at DESC').page(page)
    else
      order('created_at DESC').page(page)
    end
  end
end
