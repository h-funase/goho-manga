class CreateComics < ActiveRecord::Migration[5.2]
  def change
    create_table :comics do |t|
      t.string :title,        null: false, index: true
     
      t.text :image,           null: false
     
      t.text :text

      t.timestamps
    end
  end
end
