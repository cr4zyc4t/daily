class Report < ActiveRecord::Base
  attr_accessible :body, :title, :user_id, :catalog_id, :attach
  belongs_to :catalog
  belongs_to :user
  validates :title, :presence=> true, 
            :length => { :within => 2..80 }
  has_attached_file :attach
  validates_attachment_size :attach,:less_than => 1.megabyte
            
end
