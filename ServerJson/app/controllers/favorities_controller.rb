require 'json'

class FavoritiesController < ApplicationController
  before_action :set_favority, only: [:show, :edit, :update, :destroy]
  respond_to :json

  def index
    user = nil
    count = params[:count].to_i; count = count > 0 ? count : 10
    begin
      user = User.find(params[:user_id].to_i)
    rescue
      return render :json => {"user" => "NOT_FOUND"}
    end

    begin
      # FIXME
      @events = Event.where("events.id IN (?)", Favority.where(:user_id => 1).select(:event_id).uniq).last(count)
    rescue
      return render :json => {"@events" => "NOT_FOUND"}
    end
    render :json => @events
  end

  def new
    @favority = Favority.new
    respond_with(@favority)
  end

  def create
    @favority = Favority.new
    @favority.event_id = params[:favority][:event_id].to_i if params[:favority][:event_id] != nil
    @favority.user_id = params[:favority][:user_id].to_i if params[:favority][:event_id] != nil
    event = nil
    begin
        event = Event.find(@favority.event_id)
    rescue
      @err = "NOT_EVENT"
    end
    begin
      User.find(@favority.user_id)
    rescue
      @err = "NOT_USER"
    end
     return render :json =>  Hash['save_success', 'FAIL', "err", @err] if @err != nil
     event.popularity += 1
     event.save
     return render :json => Hash['save_success', (@favority.save ? 'SUCCESS' : 'FAIL')]
  end

  def destroy
    @favority.destroy
    event = nil
    begin
      event = Event.find(@favority.event_id)
    rescue
      @err = "NOT_EVENT"
    end
    return render :json =>  Hash['save_success', 'FAIL', "err", @err] if @err != nil
    event.popularity -= 1
    event.save
    render :json => Hash['delete_succes', 'SUCCESS']
  end

  private

  def set_favority
    @favority = Favority.find(params[:id])
  end

  def favority_params
    params.require(:favority).permit(:event_id, :user_id)
  end
end
