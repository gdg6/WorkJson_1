class Admin::EventsController < Admin::ApplicationController

  before_action :check_auth
  before_action :set_event, only: [:edit, :update, :destroy, :show]

  # GET /events/new
  def new
    @event = Event.new
  end

  def show

  end

  # GET /events/1/edit
  def edit
  end

  def index
    @events = Event.page(params[:page]).per(30)
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user_id = @current_admin.id
    return save_with_tags(@event) if params[:character_id].to_i > 0
    return save_with_check(@event)
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event.user_id = @current_admin.id
    render :json => {'update_success' => (@event.update(event_params) ? 'SUCCESS' : 'FAIL'), 'err' => @err}
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
    return redirect_to '/admin/events' unless save_ok
    tags_ids = []
    TagsToCharacter.select(:tag_id).where(:character_id => params[:character_id].to_i).load.each { |x| tags_ids << x.tag_id.to_i }
    tags_ids.each do |x|
      ett = EventsToTag.new
      ett.event_id = obj.id
      ett.tag_id = x
      ett.save
    end
    redirect_to '/admin/events'
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def setUrl
    @event.url = @event.picture.url(:medium)
    @event.save
  end

  def set_date
    @arg_date = params[:date]
    return render :json => [] if @arg_date.nil?
  end

  def event_params
    params.require(:event).permit(:user_id, :name, :adress, :date, :city_id, :time, :description, :price, :popularity, :picture, :longitude, :latitude)
  end

end
