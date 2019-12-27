class Episode < ApplicationRecord
  belongs_to :comic, inverse_of: :episodes
end
