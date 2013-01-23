class Station < ActiveRecord::Base

  has_many :states

  attr_accessible :sid, :he_name, :en_name, :he_desc, :en_desc, :lng, :ltd


  def self.all_transactions_at_dates(date0 = 1.week.ago, date1 = Time.now)
    all
  end

  def transactions_at_dates(date0 = 1.week.ago, date1 = Time.now)
    taken    = 0
    returned = 0

    current_bike_count = nil
    states.between_dates(date0, date1).each do |state|

      new_count = state.available_bikes

      if current_bike_count.present?
        if new_count > current_bike_count
          returned += new_count - current_bike_count
        elsif new_count < current_bike_count
          taken += current_bike_count - new_count
        end
      end

      current_bike_count = new_count

    end

    {:taken => taken, :returned => returned}

  end

end