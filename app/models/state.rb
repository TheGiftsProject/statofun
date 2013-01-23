class State < ActiveRecord::Base

  belongs_to :station

  attr_accessible :active, :available_bikes, :available_docks

  scope :at_day, lambda { |date| where(:created_at => date.beginning_of_day..date.end_of_day) }
  scope :between_dates, lambda { |date0, date1| where(:created_at => date0.beginning_of_day..date1.end_of_day)}

  validates_numericality_of :available_bikes, :greater_than_or_equal_to => 0
  validates_numericality_of :available_docks, :greater_than_or_equal_to => 0



end