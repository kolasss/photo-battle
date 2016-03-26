class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :number, null: false
      t.integer :status, null: false

      t.integer :battle_id, null: false
      t.integer :target_id, null: false

      t.timestamps null: false
    end

    add_index :rounds, :battle_id
    add_index :rounds, :target_id
  end
end
