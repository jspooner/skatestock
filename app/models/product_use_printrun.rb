class ProductUsePrintrun < ActiveRecord::Base
  has_and_belongs_to_many :product_categories
end
