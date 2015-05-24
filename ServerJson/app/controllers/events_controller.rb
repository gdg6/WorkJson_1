class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_auth
  before_action :check_admin, :only => [:update, :create, :destroy, :new]
  after_action  :setUrl, only: [:create, :update]

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

  def getEventByCityAndCharacter
    c = params[:count].to_i > 0 ? params[:count].to_i : 10
    p = params[:page].to_i > 0 ? paras[:page].to_i : 1
    render :json =>  Event.where("city_id = ? AND id IN (?)", @current_user.city_id, EventsToTag.select(:event_id).where("tag_id IN (?)", TagsToCharacter.select(:tag_id).where(:character_id => @current_user.character_id).load).load).page(p).per(c).load
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
    @event = Event.new(event_params)
    @event.user_id = @current_user.id
    return save_with_tags(@event) if params[:character_id].to_i > 0
    return save_with_check(@event)
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event.user_id = @current_user.id
    @event.name = params[:event][:name]
    @event.adress = params[:event][:adress]
    @event.date = params[:event][:date]
    @event.time = params[:event][:time]
    @event.description = params[:event][:description]
    @event.price= params[:event][:price].to_i
    @event.popularity = params[:event][:popularity].to_i
    @event.picture = params[:event][:picture]
    @event.longitude = params[:event][:longitude].to_f
    @event.latitude = params[:event][:latitude].to_f
    save_with_check(@event)
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    render :json => {'destroy_success' => 'SUCCESS'}
  end

  private

  def save_with_tags(obj)
    save_ok = obj.save
    return render :json => {'save_success'=>'FAIL','err'=> 'NOT_SAVE' } unless save_ok
    tags_ids = []
    TagsToCharacter.select(:tag_id).where(:character_id => params[:character_id].to_i).load.each{|x| tags_ids << x.tag_id.to_i}
    tags_ids.each do |x|
     ett =  EventsToTag.new
      ett.event_id=obj.id
      ett.tag_id=x
      ett.save
    end
    return render :json => {'save_success'=>'SUCCESS','err'=> @err }
  end

    def setUrl
      @event.url = @event.picture.url(:medium)
      @event.save
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:user_id, :name, :adress, :date, :time, :description, :price, :popularity, :picture, :longitude, :latitude )
    end
end
