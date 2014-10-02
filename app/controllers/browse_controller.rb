class BrowseController < ApplicationController

  def index
      @stock     = ImageShell.stock.all
      @editorial = ImageShell.editorial.find(:all)
  end

end
