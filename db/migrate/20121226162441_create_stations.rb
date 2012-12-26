class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :sid, :null => false
      t.string :he_name, :default => ''
      t.string :en_name, :default => ''
      t.string :he_desc, :default => ''
      t.string :en_desc, :default => ''
      t.string :lng, :null => false
      t.string :ltd, :null => false
      t.timestamps
    end
  end
end
