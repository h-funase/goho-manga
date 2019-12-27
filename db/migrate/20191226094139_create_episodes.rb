class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.integer :story_number
      t.string :url , null: false
      t.timestamps
    end
  end
end
