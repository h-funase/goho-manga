class Comic < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  has_many :comments

  def self.search(search)
    return Comic.all unless search
    Comic.where('text LIKE(?)', "%#{search}%")
  end
end
