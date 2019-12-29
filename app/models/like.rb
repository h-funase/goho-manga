class Like < ApplicationRecord
  belongs_to :comic, counter_cache: :likes_count
  belongs_to :user

  validates_uniqueness_of :comic_id, scope: :user_id

end
