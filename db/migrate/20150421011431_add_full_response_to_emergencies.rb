class AddFullResponseToEmergencies < ActiveRecord::Migration
  def change
    add_column :emergencies, :full_response, :boolean, null: false, default: false
  end
end
