class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_auth
  before_action :check_admin, :only => [:update, :create, :destroy]

  # GET /events
  # GET /events.json
  def index
    render :json => Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    render :json => @event
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  def getEventsByDateWithCountAndTag
    count = params[:count].to_i > 0 ? params[:count].to_i : 10
    event_ids = EventsToTag.select(:event_id).where(:tag_id => params[:tag_id]).load
    return render :json => Event.where("events.id IN (?) AND events.date = ?", event_ids, params[:date]).last(count)
  end

  #FIXME
  def getEventsByMounthWithCountAndTag
    count = params[:count].to_i > 0 ? params[:count].to_i : 10
    event_ids = EventsToTag.select(:event_id).where(:tag_id => params[:tag_id]).load
    from_date = (params[:date].to_i / 100) * 100 #19790500
    to_date = (from_date % 10000 >= 1200 ? from_date + 10000 : from_date + 100)
    return render :json => Event.where("events.id IN (?) AND events.date > ? AND events.date < ?", event_ids, from_date, to_date).last(count)
  end

  def getEventsByTagWithCount
    count = params[:count].to_i > 0 ? params[:count].to_i : 10
    event_ids = EventsToTag.select(:event_id).where(:tag_id => params[:tag_id]).load
    return render :json => Event.where("events.id IN (?)", event_ids).last(count)
  end

  # POST /events
  # POST /events.json
  def create
    return render :json => {'save_success' => 'FAIL', 'err' => 'NOT_ADMIN'} unless @current_user.admin
    @event = Event.new(event_params)
    @event.user_id = params[:event][:user_id].to_i
    @event.name = params[:event][:name]
    @event.adress = params[:event][:adress]
    @event.date = params[:event][:date]
    @event.time = params[:event][:time]
    @event.description = params[:event][:description]
    @event.price= params[:event][:price].to_i
    @event.popularity = params[:event][:popularity].to_i
    @event.picture = params[:event][:picture]
    save_with_check(@event)
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    return render :json => {'save_success' => 'FAIL', 'err' => 'NOT_ADMIN'} unless @current_user.admin
    @event.user_id = params[:event][:user_id].to_i
    @event.name = params[:event][:name]
    @event.adress = params[:event][:adress]
    @event.date = params[:event][:date]
    @event.time = params[:event][:time]
    @event.description = params[:event][:description]
    @event.price= params[:event][:price].to_i
    @event.popularity = params[:event][:popularity].to_i
    @event.picture = params[:event][:picture]
    save_with_check(@event)
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    return render :json => {'destroy_success' => 'FAIL', 'err' => 'NOT_ADMIN'} unless @current_user.admin
    @event.destroy
    render :json => {'destroy_success' => 'SUCCESS'}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:user_id, :name, :adress, :date, :time, :description, :price, :popularity, :picture )
    end
end
