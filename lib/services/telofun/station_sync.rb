require_relative 'station_parser.rb'

module Telofun

  module StationSync

    def self.sync(new_stations_data)

      new_stations_data.each do |raw_data|

        parsed_station = Telofun::StationParser.parse_station(raw_data)
        parsed_state   = Telofun::StationParser.parse_state(raw_data)

        station = Station.find_or_create_by_sid(parsed_station)
        station.states.create(parsed_state)

      end

    end

  end

end