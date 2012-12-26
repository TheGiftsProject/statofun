class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.integer :station_id
      t.boolean :active,          :null => false
      t.integer :available_bikes, :null => false
      t.integer :available_docks, :null => false
      t.timestamps
    end
  end
end
