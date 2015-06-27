class Admin::CitiesController < Admin::ApplicationController

  def index
    @cities = City.page(params[:page]).per(10).load
  end

  def new
    @city = City.new
  end

  def destroy

  end

  def update

  end

  def show

  end

  private

  def city_params
    params.require(:city).permit(:name)
  end

end
