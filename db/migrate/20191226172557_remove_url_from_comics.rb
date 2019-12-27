class RemoveUrlFromComics < ActiveRecord::Migration[5.2]
  def change
    remove_column :comics, :url, :text
  end
end
