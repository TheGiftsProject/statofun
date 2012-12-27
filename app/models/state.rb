class State < ActiveRecord::Base

  belongs_to :station

  attr_accessible :active, :available_bikes, :available_docks

  validates_numericality_of :available_bikes, :greater_than_or_equal_to => 0
  validates_numericality_of :available_docks, :greater_than_or_equal_to => 0

end