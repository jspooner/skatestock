class CalculatorController < ApplicationController

  before_filter :login_required
  
  def index
    @image_shell        = ImageShell.find(params[:id])
    # # don't let unelegable images to be calculated.
    # unless @image_shell.is_available_for_private_sale
    #   redirect_to "/"
    # end
    
    @line_item          = LineItem.new
    @price_usages       = PriceUsage.find(:all)
  end
  
  def show
    @price_usages       = PriceUsage.find(:all)
    
    @usages = Hash.new
    
    @price_usages.each do |u|
      @usages[u.name] = u
      @usages[u.name]["medias"] = Array.new
      for m in u.price_medias
        options                     = Hash.new 
        hi_lo                       = find_lowest_and_highest_options(m.price_options);
        max_line_item               = LineItem.new
        max_line_item.price_usage   = u
        max_line_item.price_media   = m
        max_line_item.price_options = hi_lo[1]
        min_line_item               = LineItem.new
        min_line_item.price_usage   = u
        min_line_item.price_media   = m
        min_line_item.price_options = hi_lo[0]
         
        @usages[u.name]["medias"].push({"name"=>m.name, "min_price"=>min_line_item.calculate_price, "max_price"=>max_line_item.calculate_price})
      end # medias
    end   # usage
    
  end
  
  def getUseTypes
    c = params[:editorialonly] || "0"
    # @options = PriceUsage.find(params[:id]).price_medias.find(:all, :conditions => { :is_editorial => c } ).collect { |o| [o.name, o.id] }
    @options = PriceUsage.find(params[:id]).price_medias.collect { |o| [o.name, o.id] }
    render :partial => "useTypes"
  end 
  
  def getUseOptions
    puts 'getUseOptions'
    @line_item     = LineItem.new
    @industry      = ProductUseIndustry.find(:all)
    @media         = PriceMedia.find(params[:id])
    @price_options = PriceOptionName.find(:all)
    render :partial => 'useOptions2'
  end
  
  #
  # worldwide = 15%
  # continent = 10%
  # country   = 3%
  #
  def calculate_price
    @line_item             = LineItem.new
    @line_item.price_usage = PriceUsage.find(params[:line_item][:price_usage])
    @line_item.price_media = PriceMedia.find(params[:line_item][:price_media])
    @line_item.use_territory= params[:line_item][:use_territory] || []

    options                = params[:line_item][:price_options].split(",")
    options.each do |o|
      @line_item.price_options << PriceOption.find(o)
    end
    @line_item.price = @line_item.calculate_price
    render :partial => 'price'
  end
  
  def add_to_cart
    @line_item                    = LineItem.new
    @line_item.image_shell        = ImageShell.find(params[:line_item][:image_shell])
    # @line_item.master             = Master.find(params[:line_item][:master])
    @line_item.use_industry       = params[:line_item][:use_industry]
    @line_item.use_territory      = params[:line_item][:use_territory]
    @line_item.sensitiveSubject   = params[:line_item][:sensitiveSubject]
    @line_item.use_duration_start = params[:line_item]['use_duration_start(1i)'] + "-" + params[:line_item]['use_duration_start(2i)'] + "-" + params[:line_item]['use_duration_start(3i)']
    @line_item.price              = params[:line_item][:price]
    @line_item.price_usage        = PriceUsage.find(params[:line_item][:price_usage])
    @line_item.price_media        = PriceMedia.find(params[:line_item][:price_media])
    options                       = params[:line_item][:price_options].split(",")
    options.each do |o|
      @line_item.price_options << PriceOption.find(o)
    end

    if @line_item.save
      current_cart.line_items << @line_item
      render :text => "Saved #" + @line_item.id.to_s
    else
      render :text => "ERROR"    
    end
    
  end
  
  private
  
  def find_lowest_and_highest_options options
    lowest_arr   = []
    highest_arr  = []
    # puts "=========== " + options.to_s
    options_hash = Hash.new
    options.each do |o|
      options_hash[o.option] = Array.new if options_hash[o.option] == nil 
      options_hash[o.option].push o
    end
    
    options_hash.each_value do |value| 
      # puts "val" + value.to_s 
      lowest = nil
      highest = nil
      value.each do |o|
        # puts "  op" + o.percentage.to_s
        lowest = o if lowest == nil || o.percentage < lowest.percentage
        highest = o if highest == nil || o.percentage > highest.percentage
      end
        # puts "LOWEST WAS  op" + lowest.percentage.to_s
        lowest_arr.push lowest
        highest_arr.push highest
        # puts "LOWEST collection " + lowest_arr.collect { |x| [x.option]}.to_s
    end
    
    [lowest_arr,highest_arr]
  end

  
end