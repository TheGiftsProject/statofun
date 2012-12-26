class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.integer :station_id
      t.boolean :active,          :null => false, :default => false
      t.integer :available_bikes, :null => false, :default => 0
      t.integer :available_docks, :null => false, :default => 0
      t.timestamps
    end
  end
end
