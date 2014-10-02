class ProductCategory < ActiveRecord::Base
  has_many :product_types
  has_and_belongs_to_many :product_use_placements
  has_and_belongs_to_many :product_use_durations
  has_and_belongs_to_many :product_use_printruns
  has_and_belongs_to_many :product_use_sizes
end
