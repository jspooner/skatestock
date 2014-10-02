class LineItem < ActiveRecord::Base
  # belongs_to :master
  belongs_to :image_shell
  
  has_and_belongs_to_many :price_options
  belongs_to :cart
  belongs_to :price_usage
  belongs_to :price_media
  
  def self.for_master(img)
    item             = self.new
    item.image_shell = img
    item
  end
  
  # Options are a percent of the price_usage.
  # price = BasePrice + PriceUsage + PriceMedia + ( PriceUsage.price * PriceOptions.percentage )
  # price += (PriceUsage.price * .15) per world
  # price += (PriceUsage.price * .10) per continent
  # price += (PriceUsage.price * .3)  per country
  def calculate_price
    logger.info("calculate_price ======================" )
    logger.info("calculate_price price_usage=" + self.price_usage.price.to_s)
    logger.info("calculate_price price_media=" + self.price_media.price.to_s)
    # price = image.basePrice | image.stockBasePrice
    price   = 0 # self.image_shell.stock_base_price
    sumPerc = 0
    self.price_options.each do |o|
      sumPerc += (o.percentage)
      logger.info("calculate_price price_opton=" + (o.percentage).to_s + "%")      
    end
    
    # add countries
    worldwide     = self.use_territory.include? "Worldwide"
    north_america = self.use_territory.include? "North America"
    south_america = self.use_territory.include? "South America"
    asia          = self.use_territory.include? "Asia"
    europe        = self.use_territory.include? "Europe"
    australia     = self.use_territory.include? "Australia"
    africa        = self.use_territory.include? "Africa"
    
    
   logger.info("worldwide     " + worldwide.to_s    )
   logger.info("north_america " + north_america.to_s)
   logger.info("south_america " + south_america.to_s)
   logger.info("asia          " + asia.to_s         )
   logger.info("europe        " + europe.to_s       )
   logger.info("australia     " + australia.to_s    )
   logger.info("africa        " + africa.to_s       )
                                  
    
    if worldwide
      
      price += self.price_usage.price + 0.15
      
    elsif north_america || south_america || asia || europe || australia || africa
      
      sumPerc += 0.10 if north_america
      sumPerc += 0.10 if south_america
      sumPerc += 0.10 if asia
      sumPerc += 0.10 if europe
      sumPerc += 0.10 if australia
      sumPerc += 0.10 if africa
      
    else
      
      self.use_territory.each do |t|
            sumPerc += 0.03
      end
      
    end
    
    price += self.price_usage.price + self.price_media.price
    price += (sumPerc/100.0)*price
    
    logger.info("price " + price.to_s )
    logger.info("sumPerc " + sumPerc.to_s )
    logger.info("sumPerc " + ( sumPerc/100.0 ).to_s )
    logger.info("(sumPerc/100)*price " + ( (sumPerc/100.0)*price ).to_s )     
    logger.info("calculate_price total " + price.to_s)
    logger.info("calculate_price ======================" )    
    price
  end

end
