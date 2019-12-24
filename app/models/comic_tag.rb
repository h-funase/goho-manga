class ComicTag < ApplicationRecord
  belongs_to :comic
  belongs_to :tag

  validates :article_id,presence:true
  validates :category_id,presence:true
end
