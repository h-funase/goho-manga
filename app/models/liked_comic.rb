class LikedComic < ApplicationRecord
  belongs_to :like
  belongs_to :comic
end
