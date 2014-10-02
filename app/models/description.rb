class Description < ActiveRecord::Base
  belongs_to :proof
  belongs_to :master
  has_one :image_shell
  
  has_many :images
end
