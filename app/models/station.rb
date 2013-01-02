class Station < ActiveRecord::Base

  has_many :states

  attr_accessible :sid, :he_name, :en_name, :he_desc, :en_desc, :lng, :ltd

  def states_at_day(date = Time.now)
    states.where(:created_at => date.beginning_of_day..date.end_of_day).map(&:available_bikes)
  end

end