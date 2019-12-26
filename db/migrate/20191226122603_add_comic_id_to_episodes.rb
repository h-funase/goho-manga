class AddComicIdToEpisodes < ActiveRecord::Migration[5.2]
  def change
    add_column :episodes, :comic_id, :integer
  end
end
