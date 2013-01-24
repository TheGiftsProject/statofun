require './lib/services/telofun/api'
require './lib/services/telofun/station_syncer'

class StationsController < ApplicationController

  def sync
    raw_stations_data = Telofun::API.get_all_stations
    Telofun::StationSyncer.sync(raw_stations_data)

    render :nothing => true, :status => :ok
  end

end
