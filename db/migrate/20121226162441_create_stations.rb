class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :sid, :null => false
      t.string :he_name, :default => ''
      t.string :en_name, :default => ''
      t.string :he_desc, :default => ''
      t.string :en_desc, :default => ''
      t.decimal :lng, :precision => 15, :scale => 10, :null => false, :default => 0
      t.decimal :ltd, :precision => 15, :scale => 10, :null => false, :default => 0
      t.timestamps
    end

    add_index :stations, [:sid], :name => "index_stations_on_sid", :unique => true
  end
end
