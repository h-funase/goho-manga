class CreateComicTags < ActiveRecord::Migration[5.2]
  def change
    create_table :comic_tags do |t|
      t.references :comic, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true
      t.timestamps
    end
  end
end
