class Tag < ApplicationRecord

  acts_as_taggable
  validates :name,presence:true,length:{maximum:50}
  has_many :comic_tags
  has_many :comics, through: :comic_tags
end
