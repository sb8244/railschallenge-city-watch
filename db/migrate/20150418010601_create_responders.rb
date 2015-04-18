class CreateResponders < ActiveRecord::Migration
  def change
    create_table :responders do |t|
      t.string :emergency_code
      t.string :type, null: false
      t.string :name, null: false
      t.integer :capacity, null: false
      t.boolean :on_duty, null: false, default: false

      t.timestamps null: false
    end
  end
end
