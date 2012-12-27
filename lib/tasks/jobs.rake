require_relative '../services/telofun/api'
require_relative '../services/telofun/station_syncer'

namespace :jobs do

  INTERVAL = 60

  desc 'Sync stations and states from the Telofun API to the Statofun DB'
  task :work, [] => :environment do
    loop do
      sleep INTERVAL
      raw_stations_data = Telofun::API.get_all_stations
      Telofun::StationSyncer.sync(raw_stations_data)
    end
  end

end