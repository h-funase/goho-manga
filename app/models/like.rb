class Like < ApplicationRecord
  belongs_to :comic
  belongs_to :user

  validates_uniqueness_of :comic_id, scope: :user_id

end
