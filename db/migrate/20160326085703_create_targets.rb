class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.text :desc, null: false
      t.json :criterion, null: false

      t.timestamps null: false
    end
  end
end
