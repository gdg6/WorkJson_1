class Admin::CitiesController < Admin::ApplicationController
  before_action :set_city, :only=>[:edit, :update, :destroy]

  def index
    @cities = City.page(params[:page]).per(10).load
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new
    @city.name = params[:city][:name]
    if @city.save then
      respond_to do |format|
        format.html { redirect_to '/admin/cities', notice: 'City was successfully create.' }
      end
    end

  end

  def edit
   
  end

  def destroy
    @city.destroy
    respond_to do |format|
      format.html { redirect_to '/admin/cities', notice: 'City was successfully destroyed.' }
    end
  end

  def update
    @city.name=params[:city][:name]
    if @city.save then
      respond_to do |format|
        format.html { redirect_to '/admin/cities', notice: 'City was successfully update.' }
      end
    else 
      respond_to do |format|
        format.html { redirect_to '/admin/cities', notice: 'City was failed update' }
      end
    end
  end

  private

  def set_city
     @city = City.find(params[:id])
  end

  def city_params
    params.require(:city).permit(:name)
  end

end
