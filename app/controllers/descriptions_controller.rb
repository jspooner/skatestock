class DescriptionsController < ApplicationController
  def index
    @descriptions = Description.find(:all)
  end
  
  def show
    @description = Description.find(params[:id])
  end
  
  def new
    @description = Description.new
  end
  
  def create
    @description = Description.new(params[:description])
    if @description.save
      flash[:notice] = "Successfully created description."
      redirect_to @description
    else
      render :action => 'new'
    end
  end
  
  def edit
    @image_shell = ImageShell.find(params[:image_shell_id])
    @description = @image_shell.description
  end
  
  def update
    @description = Description.find(params[:id])
    puts @description.title
    if @description.update_attributes(params[:description])
      flash[:notice] = "Successfully updated description."
      redirect_to @description
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @description = Description.find(params[:id])
    @description.destroy
    flash[:notice] = "Successfully destroyed description."
    redirect_to descriptions_url
  end
end
