require "savon"
module Test
  def self.getBikes
# create a client for your SOAP service
    client = Savon.client(wsdl: "http://www.tel-o-fun.co.il:2470/ExternalWS/Geo.asmx?WSDL")

    #client.operations

# execute a SOAP request to call the "getUser" action
    reponse = client.call(:get_nearest_stations) do
      message({
                  longitude: 32.065992,
                  langitude: 34.778252,
                  radius: 99999,
                  maxResults: 9999
              })
    end

    reponse.body
# => { :get_user_response => { :first_name => "The", :last_name => "Hoff" } }
  end
end
