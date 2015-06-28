class FavoritiesController < ApplicationController
  before_action :set_favority, only: [:destroy]
  before_action :check_auth
  respond_to :json

  def index
    count = params[:count].to_i; count = count > 0 ? count : 10
    render :json => @current_user.events.first(count)
  end

  def create
    @favority = Favority.new(favority_params)
    @favority.user_id = @current_user.id
     save_with_check(@favority)
  end

  def destroy
    @favority.destroy if @favority.user_id == @current_user.id
    render :json => {'delete_success' => 'SUCCESS'}
  end

  private

  def set_favority
    @favority = Favority.find(params[:id])
  end

  def favority_params
    params.require(:favority).permit(:event_id)
  end
end
