class CitiesController < ApplicationController
  def index
    render :json => City.select(:id, :name).all
  end
end
