require './lib/services/telofun/api'
require './lib/services/telofun/station_syncer'

class StationsController < ApplicationController

  respond_to :html, :json

  def index
    @stations = Station.all
  end

  def show
    station = Station.find(params[:id])
    last_state = station.states.last
    @station_data = OpenStruct.new({
      :name => station.he_name,
      :lng  => station.lng,
      :ltd  => station.ltd,
      :current_bikes => last_state.available_bikes,
      :current_free_docks => last_state.available_docks,
      :total_docks => last_state.available_bikes + last_state.available_docks,
    })
    respond_with(@station_data)
  end

  def sync
    raw_stations_data = Telofun::API.get_all_stations
    Telofun::StationSyncer.sync(raw_stations_data)

    render :nothing => true, :status => :ok
  end

end
