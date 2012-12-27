require "savon"

module Telofun

  module API

    def self.get_all_stations
      client = Savon.client(wsdl: "http://www.tel-o-fun.co.il:2470/ExternalWS/Geo.asmx?WSDL")

      response = client.call(:get_nearest_stations) do
        message({
                    radius:     99999,
                    longitude:  32.065992,
                    langitude:  34.778252,
                    maxResults: 9999
                })
      end

      response.to_hash[:get_nearest_stations_response][:get_nearest_stations_result][:stations_close_by][:station]
    end

  end

end
