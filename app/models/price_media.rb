class PriceMedia < ActiveRecord::Base
  belongs_to :price_usage
  has_many :price_options
  belongs_to :line_item
    
  def getOptions(name)
    price_options.get_specific_option name
  end

end
