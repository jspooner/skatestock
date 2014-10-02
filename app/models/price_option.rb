class PriceOption < ActiveRecord::Base
  belongs_to :price_media
  has_and_belongs_to_many :line_items
  
  
  named_scope :get_specific_option, lambda { |option| {:conditions => { :option => option } } }  
  
  
end
