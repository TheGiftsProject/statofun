module Telofun

  module StationParser

    def self.parse_station(station_data)
      {
        sid:     station_data[:@station_id],
        he_name: station_data[:@station_name],
        en_name: station_data[:@eng_station_name],
        he_desc: station_data[:@description],
        en_desc: station_data[:@eng_address],
        lng:     station_data[:@longitude],
        ltd:     station_data[:@latitude],
      }
    end

    def self.parse_state(station_data)
      {
          active: station_data[:@is_active],
          available_bikes: station_data[:@num_of_available_bikes],
          available_docks: station_data[:@num_of_available_docks]
      }
    end

  end

end
