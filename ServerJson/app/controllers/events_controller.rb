class EventsController < ApplicationController

  attr_reader :arg_page, :arg_count, :arg_date

  before_action :check_auth, except: [:get_events_guest, :get_events_date_guest]
  before_action :set_page_and_count, only: [:get_events, :get_events_date, :get_events_guest, :get_events_date_guest]
  before_action :set_date, only: [:get_events_date, :get_events_date_guest]


  # This getEventByCityAndCharacter for @current_user
  def get_events
    getEventByCityAndCharacter(@current_user.city_id, @current_user.character_id);
  end

  # This getEventByCityAndCharacterWithDate for @current_user
  def get_events_date
     getEventByCityAndCharacterWithDate(@current_user.city_id, @current_user.character_id, @arg_date)
  end

  # This getEventByCityAndCharacter for guest
  def get_events_guest
    city_id = params[:city_id].to_i
    character_id = params[:character_id].to_i
    return render :json => [] if city_id == 0 or character_id == 0
    getEventByCityAndCharacter(city_id, character_id)
  end

  # This getEventByCityAndCharacterWithDate for guest
  def get_events_date_guest
    city_id = params[:city_id].to_i
    character_id = params[:character_id].to_i
    return render :json => [] if city_id == 0 or character_id == 0
    getEventByCityAndCharacterWithDate(city_id, character_id, @arg_date)
  end

  def getEventsByDateWithCountAndTag
    count = params[:count].to_i > 0 ? params[:count].to_i : 10
    event_ids = EventsToTag.select(:event_id).where(:tag_id => params[:tag_id]).load
    return render :json => Event.where("events.id IN (?) AND events.start_date >= ?", event_ids, (DateTime.civil_from_format :local, params[:year], params[:month], params[:day]) ).last(count)
  end

  #FIXME - must be DateTime
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


  private

  def save_with_tags(obj)
    save_ok = obj.save
    return render :json => {'save_success' => 'FAIL', 'err' => 'NOT_SAVE'} unless save_ok
    tags_ids = []
    TagsToCharacter.select(:tag_id).where(:character_id => params[:character_id].to_i).load.each { |x| tags_ids << x.tag_id.to_i }
    tags_ids.each do |x|
      ett = EventsToTag.new
      ett.event_id = obj.id
      ett.tag_id = x
      ett.save
    end
    return render :json => {'save_success' => 'SUCCESS', 'err' => @err}
  end



  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def set_date
    @arg_date = params[:date]
    return render :json => [] if @arg_date.nil?
  end

  def set_page_and_count
    @arg_count = params[:count].to_i > 0 ? params[:count].to_i : 10
    @arg_page = params[:page].to_i > 0 ? params[:page].to_i : 1
  end

  def getEventByCityAndCharacter(city_id, character_id)
    render :json => Event.where("city_id = ? AND id IN (?)", city_id, EventsToTag.select(:event_id).where("tag_id IN (?)", TagsToCharacter.select(:tag_id).where(character_id: character_id).load).load).page(@arg_page).per(@arg_count)
  end

  def getEventByCityAndCharacterWithDate(city_id, character_id, date)
    render :json => Event.where(city_id: city_id, id: EventsToTag.select(:event_id).where(tag_id: TagsToCharacter.select(:tag_id).where(character_id: character_id).load).load, date: date).page(@arg_page).per(@arg_count).load
  end

end
