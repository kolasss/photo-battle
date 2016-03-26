class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.integer :status, null: false

      t.timestamps null: false
    end

    add_index :battles, :status
  end
end
