class CreateLikedComics < ActiveRecord::Migration[5.2]
  def change
    create_table :liked_comics do |t|
      t.references :like, foreign_key: true
      t.references :comic, foreign_key: true

      t.timestamps
    end
  end
end
