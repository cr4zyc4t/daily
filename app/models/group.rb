class Group < ActiveRecord::Base
  attr_accessible :name
  has_many :users
  has_many :replies, :through => :users, :source => :reports
  validates :name, :presence => true,
                   :uniqueness => true, 
            :length => { :within => 2..80 }
            
end
