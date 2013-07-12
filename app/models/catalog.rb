class Catalog < ActiveRecord::Base
  attr_accessible :name, :body
  has_many :reports, :dependent => :destroy
  validates :name, :presence => true,
                   :uniqueness => true, 
            :length => { :within => 2..80 }
end
