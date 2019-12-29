class AddLikesCountToComics < ActiveRecord::Migration[5.2]
  def change
    add_column :comics, :likes_count, :integer
  end
end
