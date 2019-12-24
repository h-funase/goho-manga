class Comic < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  has_many :comments

  # ここから自分で足したtagテーブルや中間テーブルのアソシエーション
  has_many :comic_tags
  has_many :tags, through: :comic_tags
  validates :name, presence: true, uniqueness: true
  def self.search(search)
    return Comic.all unless search
    Comic.where('text LIKE(?)', "%#{search}%")
  end
end
