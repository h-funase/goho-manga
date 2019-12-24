class CreateComics < ActiveRecord::Migration[5.2]
  def change
    create_table :comics do |t|
      t.string :title,        null: false, index: true
     
      t.text :url,             null: false
     
      t.integer :episode,      null: false, default: 1

      t.integer :like_count,   unique: true

      t.text :image,           null: false
     
      t.text :text,            null: false

      t.timestamps
    end
  end
end
