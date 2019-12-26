class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comics
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :liked_comics, through: :likes, source: :comic

  def already_liked?(comic)
    self.likes.exists?(comic_id: comic.id)
  end
end
