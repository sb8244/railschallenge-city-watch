class CreateEmergenciesResponders < ActiveRecord::Migration
  def change
    add_belongs_to :responders, :emergency, index: true
  end
end
