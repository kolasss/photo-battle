class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :status, null: false

      t.integer :user_id, null: false
      t.integer :battle_id, null: false

      t.timestamps null: false
    end

    add_index :participations, :user_id
    add_index :participations, :battle_id
  end
end
