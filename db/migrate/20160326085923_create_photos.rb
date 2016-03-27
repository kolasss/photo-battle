class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :file
      t.integer :status, null: false
      t.float :rating, null: false, default: 0.0

      t.integer :user_id, null: false
      t.integer :round_id, null: false

      t.timestamps null: false
    end

    add_index :photos, :user_id
    add_index :photos, :round_id
  end
end
