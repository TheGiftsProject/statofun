module Telofun

  module StationSync

    def self.sync(new_stations_data)

      new_stations_data.each do |station_data|
        sid = station_data[:@station_id]

        station = Station.find_or_created_by_sid(sid)
      end

    end

    def self.exists?(sid)

    end

  end

end