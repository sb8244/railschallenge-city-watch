class CreateEmergencies < ActiveRecord::Migration
  def change
    create_table :emergencies do |t|
      t.datetime :resolved_at
      t.string :code, null: false
      t.integer :fire_severity, null: false, default: 0
      t.integer :police_severity, null: false, default: 0
      t.integer :medical_severity, null: false, default: 0

      t.timestamps null: false
    end
  end
end
