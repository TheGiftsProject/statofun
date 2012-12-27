class Station < ActiveRecord::Base

  has_many :states

  attr_accessible :sid, :he_name, :en_name, :he_desc, :en_desc, :lng, :ltd

end