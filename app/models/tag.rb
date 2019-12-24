class Tag < ApplicationRecord
  has_many :comic_tags
  has_many :comics, through: :comic_tags
end
