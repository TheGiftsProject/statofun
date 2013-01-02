module Telofun

  class StationSerializer

    def initialize(station)
      @station = station
    end

    def to_json
      {:states => @station.states}
    end

  end

end