class FavoritiesController < ApplicationController
  before_action :set_favority, only: [:destroy]
  before_action :check_auth
  respond_to :json

  def index
    count = params[:count].to_i; count = count > 0 ? count : 10
    return render :json => @current_user.events.first(count)
  end

  def create
    @favority = Favority.new
    @favority.event_id = params[:favority][:event_id].to_i if params[:favority][:event_id] != nil
    @favority.user_id = @current_user.id
    event = Event.find(@favority.event_id).take
    return render :json =>  Hash['save_success', 'FAIL', "err", "NOT_EVENT"] unless event
    event.popularity += 1
    event.save
    save_with_check(@favority)
  end

  def destroy
    @favority.destroy
    # return render :json =>
    event = Event.find(@favority.event_id).take
    return render :json =>  Hash['delete_success', 'FAIL', "err", "NOT_EVENT"] unless event
    event.popularity -= 1
    event.save
    render :json => {'delete_success' => 'SUCCESS'}
  end

  private

  def set_favority
    @favority = Favority.find(params[:id])
  end

  def favority_params
    params.require(:favority).permit(:event_id, :user_id)
  end
end
