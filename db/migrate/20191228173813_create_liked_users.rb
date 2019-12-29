class CreateLikedUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :liked_users do |t|
      t.references :like, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
