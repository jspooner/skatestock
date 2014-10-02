class PriceUsage < ActiveRecord::Base
  has_many :price_medias
  belongs_to :line_item
end
