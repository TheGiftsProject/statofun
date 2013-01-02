#require './lib/services/telofun/station_serializer.rb'

class StationsController < ApplicationController

  respond_to :html, :json

  def index
    @stations = Station.all
  end

  def show
    station = Station.find(params[:id])
    last_state = station.states.last
    @station_data = {
      :name => station.en_name,
      :lng  => station.lng,
      :ltd  => station.ltd,
      :current_bikes => last_state.available_bikes,
      :current_free_docks => last_state.available_docks,
      :total_docks => last_state.available_bikes + last_state.available_docks,
      :states => station.states_at_day(Time.now - params[:days].to_i.days),
      :station => station
    }
    respond_with(@station_data)
  end

end
