require "savon"

module TelofunApi
  def self.get_all_stations
    client = Savon.client(wsdl: "http://www.tel-o-fun.co.il:2470/ExternalWS/Geo.asmx?WSDL")

    reponse = client.call(:get_nearest_stations) do
      message({
                  longitude: 32.065992,
                  langitude: 34.778252,
                  radius: 99999,
                  maxResults: 9999
              })
    end
    reponse.body
    doc = Nokogiri::XML(reponse.body)
    debugger
  end

end
