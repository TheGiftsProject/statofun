#require './lib/services/telofun/station_serializer.rb'

class StationsController < ApplicationController

  WEEKS = 4

  def show
    station = Station.find(params[:id])
    last_state = station.states.last
    station_data = {
      :name => station.en_name,
      :lng  => station.lng,
      :ltd  => station.ltd,
      :current_bikes => last_state.available_bikes,
      :current_free_docks => last_state.available_docks,
      :states => states_at_day(station, Time.now.yesterday)
    }

    render :json => station_data
  end

  def states_at_day(station, date = Time.now)
    station.states.where(:created_at => date.beginning_of_day..date.end_of_day)
  end

end
