class ProductType < ActiveRecord::Base
  belongs_to :product_category
end
